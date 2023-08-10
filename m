Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B83777A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbjHJOOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjHJOOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987F41B4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691676821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WxYXM6cRU3VgO4HqnDK/7ut3y9KuKig5mKLrs4m51yE=;
        b=LrAot32SLYF72zIGslYldBGITyD+D6NQwFopWuOiUo3B/A3atQ6y7Tx7SioOFjzsx6W0de
        ajcC+6Qh5iNfh1JWP739edRnI4RLg4WwKo00RKAoEAIcXFdXjpPK2s5zoCUZY6kwYNaPjD
        NDO7KFgPDk+m61C89xg6bs7V++x1O6U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-DFk5jPS6MQeqBjCgWCE0JQ-1; Thu, 10 Aug 2023 10:13:38 -0400
X-MC-Unique: DFk5jPS6MQeqBjCgWCE0JQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E024E8DC661;
        Thu, 10 Aug 2023 14:13:37 +0000 (UTC)
Received: from localhost (unknown [10.39.194.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EF275CBFF;
        Thu, 10 Aug 2023 14:13:37 +0000 (UTC)
Date:   Thu, 10 Aug 2023 10:13:35 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "longguang.yue" <kvmluck@163.com>
Cc:     Michael Tokarev <mjt@tls.msk.ru>,
        "mst@redhat.com" <mst@redhat.com>,
        qemu-devel <qemu-devel@nongnu.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: LTP test related to virtio releasing and reassigning resource
 leads to guest hung
Message-ID: <20230810141335.GA2931656@fedora>
References: <461df15f.15e2d.189deaa6eed.Coremail.kvmluck@163.com>
 <38e69323-0185-32bb-2de1-8e5b36de2abc@tls.msk.ru>
 <3c1a93da.16493.189df040e16.Coremail.kvmluck@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C0aUbutZkQIXwC4Q"
Content-Disposition: inline
In-Reply-To: <3c1a93da.16493.189df040e16.Coremail.kvmluck@163.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C0aUbutZkQIXwC4Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 06:35:32PM +0800, longguang.yue wrote:
> could you please give me some tips to diagnose?  I could do tests on qemu=
 8.0, but product environment could not update.
> I test on different kernel version 5.10.0-X, one is better and results sh=
ow problem is more about host kernel  rather than qemu.
>=20
>=20
> test cases are different combination of i440fx/q35 and virtio/scsi and ke=
rnel.

Can you post the guest kernel messages (dmesg)? If the guest is hanging
then it may be easiest to configure a serial console so the kernel
messages are sent to the host where you can see them.

Does the hang occur during the LTP code you linked or afterwards when
the PCI device is bound to a virtio driver?

Which virtio device causes the problem?

Can you describe the hang in more detail: is the guest still responsive
(e.g. console or network)? Is the QEMU HMP/QMP monitor still responsive?

Thanks,
Stefan

>=20
>=20
>=20
>=20
> thanks
>=20
>=20
>=20
>=20
> ---- Replied Message ----
> | From | Michael Tokarev<mjt@tls.msk.ru> |
> | Date | 08/10/2023 17:08 |
> | To | longguang.yue<kvmluck@163.com> ,
> qemu-devel<qemu-devel@nongnu.org> ,
> linux-kernel<linux-kernel@vger.kernel.org> |
> | Subject | Re: LTP test related to virtio releasing and reassigning reso=
urce leads to guest hung |
> 10.08.2023 11:57, longguang.yue wrote:
> Hi, all:
> A ltp test leads to guest hung(io hung), the test releases virtio device =
resource and then reassign.
> I find device=E2=80=99s mem prefetchable resource 64-bit is changed.
>=20
> ltp
> test: https://github.com/linux-test-project/ltp/blob/522d7fba4afc84e07b25=
2aa4cd91b241e81d6613/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tp=
ci.c#L428
>=20
> Do you know what cause the problem?
>=20
> Thanks very much.
>=20
> --------------------------
> ENV: kernel 5.10.0, qemu 6.2
>=20
> Current qemu is 8.1 (well, almost, to be released this month;
> previous release is 8.0 anyway).
>=20
> This might be interesting to test in a current version before
> going any further.
>=20
> Thanks,
>=20
> /mjt

--C0aUbutZkQIXwC4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTU8I8ACgkQnKSrs4Gr
c8iftQf/VbD9nqCTiUqYNyNgpBMqri6AccV8q9Bl8Cz5cyCjt1cg0Fry3XWudOzS
mNOj+3NMhcLdeVJ8RUSslk2/dFtbJN8DjVrKVAyaJt4lzZAtdcwk7EkazgifFXio
+S9Qp/HTHltKKubizxkOcrztPdxJVQroftYiM4gMQFU66153jj+CQR0HifEpaSIv
BvAijLPjEZCRypnXJctOkOh1X9IhddkXj/WVzaebqNKtzo6nCKlilyzGkj4QWWDq
mXtOls4skkbGQr0109aXYWZ0VC/f8LAG2rdGV7wNvdn2hlan302GV9OANtoAr9zE
RIU30sexogHvshQKciba5s95wgfP9w==
=0C0d
-----END PGP SIGNATURE-----

--C0aUbutZkQIXwC4Q--

