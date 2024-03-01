Return-Path: <linux-kernel+bounces-88551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C9D86E34C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CDD1C22059
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F766F515;
	Fri,  1 Mar 2024 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uAXwPk0s"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD896F061;
	Fri,  1 Mar 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303191; cv=none; b=JsBHhQAAG5/4adLGso/GvCY9C6enxVQ+90J8XUIEWqyHoIE1jG6OyERz+2onY0C+He1Eo3akQLsThRuwCHhQLVmP+Ur368NWX4xfsphudLaLZeLW2gi4IdHCM+plFUNikXNxnjrHY7B+2pTugF7+eJbKIcS1wiY2tzj0wVpeVUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303191; c=relaxed/simple;
	bh=xLLbFCitdEhU1RvTDI817HAwsCfV863rjSvWqc1GrrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tjw0MJXf3QzX1YMsO1pHpKoHuCSeW1nsNJ3wQa7l57POMVBrIRrxj9CYMhSBj9N2p+WVlxuMpCcLolysYEjuJMKeseAI0DMpbbCsMZK4dPvxl/TWMOjoJMEwlnx//v5CQovuDOPOUWLGNTufAXi+ocF9hi/vzBY8MU5QN/Ou1zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uAXwPk0s; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709303186;
	bh=xLLbFCitdEhU1RvTDI817HAwsCfV863rjSvWqc1GrrE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uAXwPk0saTLazKJAQuPEkQzPgl1s3PhwwVTT5ddGZAev8koH47hMrAPhPdSxuaqig
	 MNgfj54ywMgabYr+bxWA82k8m+YZiegNgvbOXmEA7LyEg4wpzAtlmSV4HXPhfPL9ur
	 UovwRsOV8WEBSBzTn5W7dhl5hOc0xsUktzPLVI5nh7NBx8+b7D+dgte4CdZdvh3H3B
	 b3zCpcVaOnqUEgqdLS6qa77R9BdsZKbx9g73i0xmjpOQq/ljsmkmBwdVQjiXItog9p
	 90KfHsbPe+v4kS4GEeE0EosemQNZHA16178Vlr73hg27RJ7EIN5gtp59X7ndChTjrw
	 dbXmiVrAJWGoA==
Received: from [100.95.196.182] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: andrzej.p)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 094ED37803EE;
	Fri,  1 Mar 2024 14:26:25 +0000 (UTC)
Message-ID: <0d2fc837-a7b4-4d6f-9359-f2b64fe16f92@collabora.com>
Date: Fri, 1 Mar 2024 15:26:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] tools: usb: p9_fwd: add usb gadget packet
 forwarder script
Content-Language: en-US
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 kernel@pengutronix.de
References: <20240116-ml-topic-u9p-v2-0-b46cbf592962@pengutronix.de>
 <20240116-ml-topic-u9p-v2-4-b46cbf592962@pengutronix.de>
From: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20240116-ml-topic-u9p-v2-4-b46cbf592962@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Michael,

W dniu 2.02.2024 o 01:05, Michael Grzeschik pisze:
> This patch is adding an small python tool to forward 9pfs requests
> from the USB gadget to an existing 9pfs TCP server. Since currently all
> 9pfs servers lack support for the usb transport this tool is an useful
> helper to get started.
> 
> Refer the Documentation section "USBG Example" in
> Documentation/filesystems/9p.rst on how to use it.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> ---
> v1 -> v2:
>    - added usbg 9pfs detailed instructions to 9p.rst doc
> ---
>   Documentation/filesystems/9p.rst |  32 +++++++
>   tools/usb/p9_fwd.py              | 194 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 226 insertions(+)
> 
> diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
> index 64439068a8fc5..264265c72ba67 100644
> --- a/Documentation/filesystems/9p.rst
> +++ b/Documentation/filesystems/9p.rst
> @@ -67,6 +67,38 @@ To mount a 9p FS on a USB Host accessible via the gadget as root filesystem::
>   where mount_tag is the tag associated by the usb gadget transport. The
>   pattern is usb9pfs0, usb9pfs1, ...
>   
> +USBG Example
> +============
> +
> +The USB host exports a filesystem, while the gadget on the USB device
> +side makes it mountable.
> +
> +Diod (9pfs server) and the forwarder are on the development host, where
> +the root filesystem is actually stored. The gadget is initialized during
> +boot (or later) on the embedded board. Then the forwarder will find it
> +on the USB bus and start forwarding requests.
> +
> +In this case the 9p requests come from the device and are handled by the
> +host. The reason is that USB device ports are normally not available on
> +PCs, so a connection in the other direction would not work.
> +
> +When using the usbg transport, for now there is no native usb host
> +service capable to handle the requests from the gadget driver. For
> +this we have to use the extra python tool p9_fwd.py from tools/usb.
> +
> +Just start the 9pfs capable network server like diod/nfs-ganesha e.g.:
> +
> +	$ diod -f -n -d 0 -S -l 0.0.0.0:9999 -e $PWD
> +
> +Then start the python transport:
> +
> +	$ python $kernel_dir/tools/usb/p9_fwd.py -p 9999
> +
> +After that the gadget driver can be used as described above.

Hmm... The "described above" portion refers to <mount_tag>. How do I get my
<mount_tag> if I run diod combined with p9_fwd.py?

Regards,

Andrzej

> +
> +One use-case is to use it as an alternative to NFS root booting during
> +the development of embedded Linux devices.
> +
>   Options
>   =======
>   
> diff --git a/tools/usb/p9_fwd.py b/tools/usb/p9_fwd.py
> new file mode 100755
> index 0000000000000..95208df11abef
> --- /dev/null
> +++ b/tools/usb/p9_fwd.py
> @@ -0,0 +1,194 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import argparse
> +import errno
> +import logging
> +import socket
> +import struct
> +import sys
> +import time
> +
> +import usb.core
> +import usb.util
> +
> +
> +class Forwarder:
> +    HEXDUMP_FILTER = (
> +        "".join(chr(x).isprintable() and chr(x) or "." for x in range(128)) + "." * 128
> +    )
> +
> +    @staticmethod
> +    def _log_hexdump(data):
> +        if not logging.root.isEnabledFor(logging.TRACE):
> +            return
> +        L = 16
> +        for c in range(0, len(data), L):
> +            chars = data[c : c + L]
> +            dump = " ".join(f"{x:02x}" for x in chars)
> +            printable = "".join(HEXDUMP_FILTER[x] for x in chars)
> +            line = f"{c:08x}  {dump:{L*3}s} |{printable:{L}s}|"
> +            logging.root.log(logging.TRACE, "%s", line)
> +
> +    def __init__(self, server):
> +        self.stats = {
> +            "c2s packets": 0,
> +            "c2s bytes": 0,
> +            "s2c packets": 0,
> +            "s2c bytes": 0,
> +        }
> +        self.stats_logged = time.monotonic()
> +
> +        dev = usb.core.find(idVendor=0x1D6B, idProduct=0x0109)
> +        if dev is None:
> +            raise ValueError("Device not found")
> +
> +        logging.info(f"found device: {dev.bus}/{dev.address}")
> +
> +        # dev.set_configuration() is not necessary since g_multi has only one
> +        usb9pfs = None
> +        # g_multi adds 9pfs as last interface
> +        cfg = dev.get_active_configuration()
> +        for intf in cfg:
> +            # we have to detach the usb-storage driver from multi gadget since
> +            # stall option could be set, which will lead to spontaneous port
> +            # resets and our transfers will run dead
> +            if intf.bInterfaceClass == 0x08:
> +                if dev.is_kernel_driver_active(intf.bInterfaceNumber):
> +                    dev.detach_kernel_driver(intf.bInterfaceNumber)
> +
> +            if (
> +                intf.bInterfaceClass == 0xFF
> +                and intf.bInterfaceSubClass == 0xFF
> +                and intf.bInterfaceProtocol == 0x09
> +            ):
> +                usb9pfs = intf
> +        if usb9pfs is None:
> +            raise ValueError("Interface not found")
> +
> +        logging.info(f"claiming interface:\n{usb9pfs}")
> +        usb.util.claim_interface(dev, usb9pfs.bInterfaceNumber)
> +        ep_out = usb.util.find_descriptor(
> +            usb9pfs,
> +            custom_match=lambda e: usb.util.endpoint_direction(e.bEndpointAddress)
> +            == usb.util.ENDPOINT_OUT,
> +        )
> +        assert ep_out is not None
> +        ep_in = usb.util.find_descriptor(
> +            usb9pfs,
> +            custom_match=lambda e: usb.util.endpoint_direction(e.bEndpointAddress)
> +            == usb.util.ENDPOINT_IN,
> +        )
> +        assert ep_in is not None
> +        logging.info(f"interface claimed")
> +
> +        self.ep_out = ep_out
> +        self.ep_in = ep_in
> +        self.dev = dev
> +
> +        # create and connect socket
> +        self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
> +        self.s.connect(server)
> +
> +        logging.info(f"connected to server")
> +
> +    def c2s(self):
> +        """forward a request from the USB client to the TCP server"""
> +        data = None
> +        while data is None:
> +            try:
> +                logging.log(logging.TRACE, "c2s: reading")
> +                data = self.ep_in.read(self.ep_in.wMaxPacketSize)
> +            except usb.core.USBTimeoutError:
> +                logging.log(logging.TRACE, "c2s: reading timed out")
> +                continue
> +            except usb.core.USBError as e:
> +                if e.errno == errno.EIO:
> +                    logging.debug("c2s: reading failed with %s, retrying", repr(e))
> +                    time.sleep(0.5)
> +                    continue
> +                else:
> +                    logging.error("c2s: reading failed with %s, aborting", repr(e))
> +                    raise
> +        size = struct.unpack("<I", data[:4])[0]
> +        while len(data) < size:
> +            data += self.ep_in.read(size - len(data))
> +        logging.log(logging.TRACE, "c2s: writing")
> +        self._log_hexdump(data)
> +        self.s.send(data)
> +        logging.debug("c2s: forwarded %i bytes", size)
> +        self.stats["c2s packets"] += 1
> +        self.stats["c2s bytes"] += size
> +
> +    def s2c(self):
> +        """forward a response from the TCP server to the USB client"""
> +        logging.log(logging.TRACE, "s2c: reading")
> +        data = self.s.recv(4)
> +        size = struct.unpack("<I", data[:4])[0]
> +        while len(data) < size:
> +            data += self.s.recv(size - len(data))
> +        logging.log(logging.TRACE, "s2c: writing")
> +        self._log_hexdump(data)
> +        while data:
> +            written = self.ep_out.write(data)
> +            assert written > 0
> +            data = data[written:]
> +        if size % self.ep_out.wMaxPacketSize == 0:
> +            logging.log(logging.TRACE, "sending zero length packet")
> +            self.ep_out.write(b"")
> +        logging.debug("s2c: forwarded %i bytes", size)
> +        self.stats["s2c packets"] += 1
> +        self.stats["s2c bytes"] += size
> +
> +    def log_stats(self):
> +        logging.info("statistics:")
> +        for k, v in self.stats.items():
> +            logging.info(f"  {k+':':14s} {v}")
> +
> +    def log_stats_interval(self, interval=5):
> +        if (time.monotonic() - self.stats_logged) < interval:
> +            return
> +
> +        self.log_stats()
> +        self.stats_logged = time.monotonic()
> +
> +
> +def main():
> +    parser = argparse.ArgumentParser(
> +        description="Forward 9PFS requests from USB to TCP",
> +    )
> +
> +    parser.add_argument(
> +        "-s", "--server", type=str, default="127.0.0.1", help="server hostname"
> +    )
> +    parser.add_argument("-p", "--port", type=int, default=564, help="server port")
> +    parser.add_argument("-v", "--verbose", action="count", default=0)
> +
> +    args = parser.parse_args()
> +
> +    logging.TRACE = logging.DEBUG - 5
> +    logging.addLevelName(logging.TRACE, "TRACE")
> +
> +    if args.verbose >= 2:
> +        level = logging.TRACE
> +    elif args.verbose:
> +        level = logging.DEBUG
> +    else:
> +        level = logging.INFO
> +    logging.basicConfig(
> +        level=level, format="%(asctime)-15s %(levelname)-8s %(message)s"
> +    )
> +
> +    f = Forwarder(server=(args.server, args.port))
> +
> +    try:
> +        while True:
> +            f.c2s()
> +            f.s2c()
> +            f.log_stats_interval()
> +    finally:
> +        f.log_stats()
> +
> +
> +if __name__ == "__main__":
> +    main()
> 


