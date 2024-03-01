Return-Path: <linux-kernel+bounces-88930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EC486E894
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E9F1C22A5B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C321D38F99;
	Fri,  1 Mar 2024 18:39:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2E52AD1C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318365; cv=none; b=GL+6luh5Zvlpy17Eigp2dgjQZ4IuUVrlV/ZUzCKo4o3suIp338IB6F/B2m+vH9HD9KJyFVJhe/a7sYeC1o1IccFsKW7/OttX2Vxuc1AV+lPKiHwLoEUtpvkmFw1ZZO/CxGRuIpUop6VEXkBu8iZduPZBqlYeaAyWYk5ZSWnsdCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318365; c=relaxed/simple;
	bh=GU6lA2nzJYY9HvqDqtP25BcdwxKHs1g+gkhdeyPZN8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZO0Nyi4Nh7kytGO4BaDgTr7rwHdJdQdW0m2xcMRFbBG4u9NBgA7b83BYI4SqEmg0fE0/PcDbUz8jeiKZ4LTgMW0v9hLPWH2tO5Mmw92dzJNUmXr6PzpKIoLjLqBA3kzNQ7z6iq4G09ywJtxi2+5QvjFqeHnsAuoR9LqBJALX+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1rg7mj-0004aH-Pl; Fri, 01 Mar 2024 19:39:05 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1rg7mf-003pdp-0u; Fri, 01 Mar 2024 19:39:01 +0100
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1rg7me-00FAeD-31;
	Fri, 01 Mar 2024 19:39:00 +0100
Date: Fri, 1 Mar 2024 19:39:00 +0100
From: Michael Grzeschik <mgr@pengutronix.de>
To: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v2 4/4] tools: usb: p9_fwd: add usb gadget packet
 forwarder script
Message-ID: <ZeIgxGn34RHdy4qS@pengutronix.de>
References: <20240116-ml-topic-u9p-v2-0-b46cbf592962@pengutronix.de>
 <20240116-ml-topic-u9p-v2-4-b46cbf592962@pengutronix.de>
 <0d2fc837-a7b4-4d6f-9359-f2b64fe16f92@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IRMdcDxqLjOcUVPK"
Content-Disposition: inline
In-Reply-To: <0d2fc837-a7b4-4d6f-9359-f2b64fe16f92@collabora.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--IRMdcDxqLjOcUVPK
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 03:26:24PM +0100, Andrzej Pietrasiewicz wrote:
>Hi Michael,
>
>W dniu 2.02.2024 o=A001:05, Michael Grzeschik pisze:
>>This patch is adding an small python tool to forward 9pfs requests
>>from the USB gadget to an existing 9pfs TCP server. Since currently all
>>9pfs servers lack support for the usb transport this tool is an useful
>>helper to get started.
>>
>>Refer the Documentation section "USBG Example" in
>>Documentation/filesystems/9p.rst on how to use it.
>>
>>Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>
>>---
>>v1 -> v2:
>>   - added usbg 9pfs detailed instructions to 9p.rst doc
>>---
>>  Documentation/filesystems/9p.rst |  32 +++++++
>>  tools/usb/p9_fwd.py              | 194 ++++++++++++++++++++++++++++++++=
+++++++
>>  2 files changed, 226 insertions(+)
>>
>>diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems=
/9p.rst
>>index 64439068a8fc5..264265c72ba67 100644
>>--- a/Documentation/filesystems/9p.rst
>>+++ b/Documentation/filesystems/9p.rst
>>@@ -67,6 +67,38 @@ To mount a 9p FS on a USB Host accessible via the gadg=
et as root filesystem::
>>  where mount_tag is the tag associated by the usb gadget transport. The
>>  pattern is usb9pfs0, usb9pfs1, ...
>>+USBG Example
>>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>+
>>+The USB host exports a filesystem, while the gadget on the USB device
>>+side makes it mountable.
>>+
>>+Diod (9pfs server) and the forwarder are on the development host, where
>>+the root filesystem is actually stored. The gadget is initialized during
>>+boot (or later) on the embedded board. Then the forwarder will find it
>>+on the USB bus and start forwarding requests.
>>+
>>+In this case the 9p requests come from the device and are handled by the
>>+host. The reason is that USB device ports are normally not available on
>>+PCs, so a connection in the other direction would not work.
>>+
>>+When using the usbg transport, for now there is no native usb host
>>+service capable to handle the requests from the gadget driver. For
>>+this we have to use the extra python tool p9_fwd.py from tools/usb.
>>+
>>+Just start the 9pfs capable network server like diod/nfs-ganesha e.g.:
>>+
>>+	$ diod -f -n -d 0 -S -l 0.0.0.0:9999 -e $PWD
>>+
>>+Then start the python transport:
>>+
>>+	$ python $kernel_dir/tools/usb/p9_fwd.py -p 9999
>>+
>>+After that the gadget driver can be used as described above.
>
>Hmm... The "described above" portion refers to <mount_tag>. How do I get my
><mount_tag> if I run diod combined with p9_fwd.py?

The mount_tag is decribing the instance of the usb gadget. So, when you
are describing only one gadget this will always be usb9pfs0.

The tools diod and p9_fwd.py don't need any mount_tag information.

9PFS can be sometimes a bit confusing, in regards of what shall be
mounted where. The filesystem path that should be shared by 9pfs
is always represented with the "aname" property.

Regards,
Michael

>>+
>>+One use-case is to use it as an alternative to NFS root booting during
>>+the development of embedded Linux devices.
>>+
>>  Options
>>  =3D=3D=3D=3D=3D=3D=3D
>>diff --git a/tools/usb/p9_fwd.py b/tools/usb/p9_fwd.py
>>new file mode 100755
>>index 0000000000000..95208df11abef
>>--- /dev/null
>>+++ b/tools/usb/p9_fwd.py
>>@@ -0,0 +1,194 @@
>>+#!/usr/bin/env python3
>>+# SPDX-License-Identifier: GPL-2.0
>>+
>>+import argparse
>>+import errno
>>+import logging
>>+import socket
>>+import struct
>>+import sys
>>+import time
>>+
>>+import usb.core
>>+import usb.util
>>+
>>+
>>+class Forwarder:
>>+    HEXDUMP_FILTER =3D (
>>+        "".join(chr(x).isprintable() and chr(x) or "." for x in range(12=
8)) + "." * 128
>>+    )
>>+
>>+    @staticmethod
>>+    def _log_hexdump(data):
>>+        if not logging.root.isEnabledFor(logging.TRACE):
>>+            return
>>+        L =3D 16
>>+        for c in range(0, len(data), L):
>>+            chars =3D data[c : c + L]
>>+            dump =3D " ".join(f"{x:02x}" for x in chars)
>>+            printable =3D "".join(HEXDUMP_FILTER[x] for x in chars)
>>+            line =3D f"{c:08x}  {dump:{L*3}s} |{printable:{L}s}|"
>>+            logging.root.log(logging.TRACE, "%s", line)
>>+
>>+    def __init__(self, server):
>>+        self.stats =3D {
>>+            "c2s packets": 0,
>>+            "c2s bytes": 0,
>>+            "s2c packets": 0,
>>+            "s2c bytes": 0,
>>+        }
>>+        self.stats_logged =3D time.monotonic()
>>+
>>+        dev =3D usb.core.find(idVendor=3D0x1D6B, idProduct=3D0x0109)
>>+        if dev is None:
>>+            raise ValueError("Device not found")
>>+
>>+        logging.info(f"found device: {dev.bus}/{dev.address}")
>>+
>>+        # dev.set_configuration() is not necessary since g_multi has onl=
y one
>>+        usb9pfs =3D None
>>+        # g_multi adds 9pfs as last interface
>>+        cfg =3D dev.get_active_configuration()
>>+        for intf in cfg:
>>+            # we have to detach the usb-storage driver from multi gadget=
 since
>>+            # stall option could be set, which will lead to spontaneous =
port
>>+            # resets and our transfers will run dead
>>+            if intf.bInterfaceClass =3D=3D 0x08:
>>+                if dev.is_kernel_driver_active(intf.bInterfaceNumber):
>>+                    dev.detach_kernel_driver(intf.bInterfaceNumber)
>>+
>>+            if (
>>+                intf.bInterfaceClass =3D=3D 0xFF
>>+                and intf.bInterfaceSubClass =3D=3D 0xFF
>>+                and intf.bInterfaceProtocol =3D=3D 0x09
>>+            ):
>>+                usb9pfs =3D intf
>>+        if usb9pfs is None:
>>+            raise ValueError("Interface not found")
>>+
>>+        logging.info(f"claiming interface:\n{usb9pfs}")
>>+        usb.util.claim_interface(dev, usb9pfs.bInterfaceNumber)
>>+        ep_out =3D usb.util.find_descriptor(
>>+            usb9pfs,
>>+            custom_match=3Dlambda e: usb.util.endpoint_direction(e.bEndp=
ointAddress)
>>+            =3D=3D usb.util.ENDPOINT_OUT,
>>+        )
>>+        assert ep_out is not None
>>+        ep_in =3D usb.util.find_descriptor(
>>+            usb9pfs,
>>+            custom_match=3Dlambda e: usb.util.endpoint_direction(e.bEndp=
ointAddress)
>>+            =3D=3D usb.util.ENDPOINT_IN,
>>+        )
>>+        assert ep_in is not None
>>+        logging.info(f"interface claimed")
>>+
>>+        self.ep_out =3D ep_out
>>+        self.ep_in =3D ep_in
>>+        self.dev =3D dev
>>+
>>+        # create and connect socket
>>+        self.s =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)
>>+        self.s.connect(server)
>>+
>>+        logging.info(f"connected to server")
>>+
>>+    def c2s(self):
>>+        """forward a request from the USB client to the TCP server"""
>>+        data =3D None
>>+        while data is None:
>>+            try:
>>+                logging.log(logging.TRACE, "c2s: reading")
>>+                data =3D self.ep_in.read(self.ep_in.wMaxPacketSize)
>>+            except usb.core.USBTimeoutError:
>>+                logging.log(logging.TRACE, "c2s: reading timed out")
>>+                continue
>>+            except usb.core.USBError as e:
>>+                if e.errno =3D=3D errno.EIO:
>>+                    logging.debug("c2s: reading failed with %s, retrying=
", repr(e))
>>+                    time.sleep(0.5)
>>+                    continue
>>+                else:
>>+                    logging.error("c2s: reading failed with %s, aborting=
", repr(e))
>>+                    raise
>>+        size =3D struct.unpack("<I", data[:4])[0]
>>+        while len(data) < size:
>>+            data +=3D self.ep_in.read(size - len(data))
>>+        logging.log(logging.TRACE, "c2s: writing")
>>+        self._log_hexdump(data)
>>+        self.s.send(data)
>>+        logging.debug("c2s: forwarded %i bytes", size)
>>+        self.stats["c2s packets"] +=3D 1
>>+        self.stats["c2s bytes"] +=3D size
>>+
>>+    def s2c(self):
>>+        """forward a response from the TCP server to the USB client"""
>>+        logging.log(logging.TRACE, "s2c: reading")
>>+        data =3D self.s.recv(4)
>>+        size =3D struct.unpack("<I", data[:4])[0]
>>+        while len(data) < size:
>>+            data +=3D self.s.recv(size - len(data))
>>+        logging.log(logging.TRACE, "s2c: writing")
>>+        self._log_hexdump(data)
>>+        while data:
>>+            written =3D self.ep_out.write(data)
>>+            assert written > 0
>>+            data =3D data[written:]
>>+        if size % self.ep_out.wMaxPacketSize =3D=3D 0:
>>+            logging.log(logging.TRACE, "sending zero length packet")
>>+            self.ep_out.write(b"")
>>+        logging.debug("s2c: forwarded %i bytes", size)
>>+        self.stats["s2c packets"] +=3D 1
>>+        self.stats["s2c bytes"] +=3D size
>>+
>>+    def log_stats(self):
>>+        logging.info("statistics:")
>>+        for k, v in self.stats.items():
>>+            logging.info(f"  {k+':':14s} {v}")
>>+
>>+    def log_stats_interval(self, interval=3D5):
>>+        if (time.monotonic() - self.stats_logged) < interval:
>>+            return
>>+
>>+        self.log_stats()
>>+        self.stats_logged =3D time.monotonic()
>>+
>>+
>>+def main():
>>+    parser =3D argparse.ArgumentParser(
>>+        description=3D"Forward 9PFS requests from USB to TCP",
>>+    )
>>+
>>+    parser.add_argument(
>>+        "-s", "--server", type=3Dstr, default=3D"127.0.0.1", help=3D"ser=
ver hostname"
>>+    )
>>+    parser.add_argument("-p", "--port", type=3Dint, default=3D564, help=
=3D"server port")
>>+    parser.add_argument("-v", "--verbose", action=3D"count", default=3D0)
>>+
>>+    args =3D parser.parse_args()
>>+
>>+    logging.TRACE =3D logging.DEBUG - 5
>>+    logging.addLevelName(logging.TRACE, "TRACE")
>>+
>>+    if args.verbose >=3D 2:
>>+        level =3D logging.TRACE
>>+    elif args.verbose:
>>+        level =3D logging.DEBUG
>>+    else:
>>+        level =3D logging.INFO
>>+    logging.basicConfig(
>>+        level=3Dlevel, format=3D"%(asctime)-15s %(levelname)-8s %(messag=
e)s"
>>+    )
>>+
>>+    f =3D Forwarder(server=3D(args.server, args.port))
>>+
>>+    try:
>>+        while True:
>>+            f.c2s()
>>+            f.s2c()
>>+            f.log_stats_interval()
>>+    finally:
>>+        f.log_stats()
>>+
>>+
>>+if __name__ =3D=3D "__main__":
>>+    main()
>>
>
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--IRMdcDxqLjOcUVPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmXiIL8ACgkQC+njFXoe
LGRC4hAAjm/5XF6e7oT7EzDpOeuW1EedWRXJz+sCGoR9dlptBsoPSXH0D4JCLg5a
/AJDWQmT3kW+WiaK8dtEDFXkAm6iBqRj1FfTD7DZoyOIQAEqpn+3KDETcjjngl79
rgEPvkict3KO8hTkrtY5nLI7W6nkUnQ3VhAKt1glIi+yh36QY4dYbvtpdjYkeu5A
pQCfJK3yiyYlPeofShKFKCaHIUs7KZoN36UyiuRAGVCJNcjghmlSSZC96el5uGVM
xjihMrZSO9pjduMULSTfTZfsNx2kUaNJxpGsFD8OMlQwJzQohD5p+xToHqS8l7gB
QfHtEy4maB+qLbgkF8ZXXOC0+CcfuNlbYuTzeyGcQVeJ1iB0fSsnQ1+elT6azUGd
Ac1OVL5Ay85zmFkUluz1R+H/2o+kU56aF/7aLQ3ygkZ4FiSyqRWtvl/OOoc8koVX
3kMzTz+4kLGP+U1ai/T7okQVAw7tM4F+3BW88FdegngSvqGkXmGUaEDPiIOBdz4H
pFoXOlKMtSz+bsA+mdHPOA+rgznXP+IHOuCUFjdO4Wy3RUmK+xiIWXvpRcha0dsg
pBoDzM7DLWZwy+i/O20kxCVEmr3LkppSNCUP20F46EGUVggvC2QQvwycrgrsO+Bj
sUzGxe08KqCap3/W4iVBcRp+Og6xCbDQNv+JpcD/0EQeXbj+UtY=
=Auy1
-----END PGP SIGNATURE-----

--IRMdcDxqLjOcUVPK--

