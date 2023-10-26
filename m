Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EEF7D83DD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345105AbjJZNur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjJZNuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3824F1A2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698328194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNkd6PpCHNEvlhYWQiRlA3vMPX+LENdTaqWKtjBEFxY=;
        b=avTGadn+VqxzRlgs5Na9tohxM8B5YHzxU1FmZQQsgLfyKPWQux3MBrUSUH52S7F3MnOT66
        b42EpupaK2XUb7JKVPvqEdaH6BvnlWcQx92CefuWPZiA5P9ANsWG6Jbj3cLWM2VL8NkAMc
        ASDESbEnaKwrbIpihApkJTjIcSwI4yc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-0m8kzp5ROnad1MoAcEc2bQ-1; Thu, 26 Oct 2023 09:49:50 -0400
X-MC-Unique: 0m8kzp5ROnad1MoAcEc2bQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6311B811E86;
        Thu, 26 Oct 2023 13:49:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.2.14.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0722340C6F79;
        Thu, 26 Oct 2023 13:49:48 +0000 (UTC)
Message-ID: <8a8d4a7787e9d8b4f7f3c119b057ec4a8a6b1a91.camel@redhat.com>
Subject: Re: [PATCH] USB: serial: option: add Fibocom L7xx modules
From:   Dan Williams <dcbw@redhat.com>
To:     Victor Fragoso <victorffs@hotmail.com>,
        "johan@kernel.org" <johan@kernel.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 26 Oct 2023 08:49:48 -0500
In-Reply-To: <9315051ae981aaad1d46724641defc6e5f79d12b.camel@hotmail.com>
References: <9315051ae981aaad1d46724641defc6e5f79d12b.camel@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-26 at 01:24 +0000, Victor Fragoso wrote:
> Add support for Fibocom L7xx module series and variants.
>=20
> L716-EU-60 (ECM):
> T:=C2=A0 Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D 17 Spd=3D=
480=C2=A0 MxCh=3D 0
> D:=C2=A0 Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=
=3D=C2=A0 1
> P:=C2=A0 Vendor=3D19d2 ProdID=3D0579 Rev=3D 1.00
> S:=C2=A0 Manufacturer=3DFibocom,Incorporated
> S:=C2=A0 Product=3DFibocom Mobile Boardband
> S:=C2=A0 SerialNumber=3D1234567890ABCDEF
> C:* #Ifs=3D 7 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
> A:=C2=A0 FirstIf#=3D 0 IfCount=3D 2 Cls=3D02(comm.) Sub=3D06 Prot=3D00
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D02(comm.) Sub=3D06 Prot=3D00 Driver=
=3Dcdc_ether
> E:=C2=A0 Ad=3D87(I) Atr=3D03(Int.) MxPS=3D=C2=A0 16 Ivl=3D32ms
> I:=C2=A0 If#=3D 1 Alt=3D 0 #EPs=3D 0 Cls=3D0a(data ) Sub=3D00 Prot=3D00 D=
river=3Dcdc_ether
> I:* If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3D0a(data ) Sub=3D00 Prot=3D00 Driver=
=3Dcdc_ether
> E:=C2=A0 Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:=C2=A0 Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:=C2=A0 Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:=C2=A0 Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 3 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:=C2=A0 Ad=3D83(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:=C2=A0 Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 4 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:=C2=A0 Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:=C2=A0 Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 5 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:=C2=A0 Ad=3D85(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:=C2=A0 Ad=3D05(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 6 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D42 Prot=3D01 Driver=
=3Dusbfs
> E:=C2=A0 Ad=3D86(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:=C2=A0 Ad=3D06(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
>=20
> L716-EU-60 (RNDIS):
> T:=C2=A0 Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D 21 Spd=3D=
480=C2=A0 MxCh=3D 0
> D:=C2=A0 Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=
=3D=C2=A0 1
> P:=C2=A0 Vendor=3D2cb7 ProdID=3D0001 Rev=3D 1.00
> S:=C2=A0 Manufacturer=3DFibocom,Incorporated
> S:=C2=A0 Product=3DFibocom Mobile Boardband
> S:=C2=A0 SerialNumber=3D1234567890ABCDEF
> C:* #Ifs=3D 7 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
> A:=C2=A0 FirstIf#=3D 0 IfCount=3D 2 Cls=3D02(comm.) Sub=3D06 Prot=3D00
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D02(comm.) Sub=3D06 Prot=3D00 Driver=
=3Dcdc_ether
> E:=C2=A0 Ad=3D87(I) Atr=3D03(Int.) MxPS=3D=C2=A0 16 Ivl=3D32ms
> I:=C2=A0 If#=3D 1 Alt=3D 0 #EPs=3D 0 Cls=3D0a(data ) Sub=3D00 Prot=3D00 D=
river=3Dcdc_ether
> I:* If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3D0a(data ) Sub=3D00 Prot=3D00 Driver=
=3Dcdc_ether
> E:=C2=A0 Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:=C2=A0 Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:=C2=A0 Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:=C2=A0 Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 3 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:=C2=A0 Ad=3D83(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:=C2=A0 Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 4 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:=C2=A0 Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:=C2=A0 Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 5 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:=C2=A0 Ad=3D85(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:=C2=A0 Ad=3D05(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 6 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D42 Prot=3D01 Driver=
=3Dusbfs
> E:=C2=A0 Ad=3D86(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:=C2=A0 Ad=3D06(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
>=20
> L716-EU-10 (ECM):
> T:=C2=A0 Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D 21 Spd=3D=
480=C2=A0 MxCh=3D 0
> D:=C2=A0 Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=
=3D=C2=A0 1
> P:=C2=A0 Vendor=3D2cb7 ProdID=3D0001 Rev=3D 1.00
> S:=C2=A0 Manufacturer=3DFibocom,Incorporated
> S:=C2=A0 Product=3DFibocom Mobile Boardband
> S:=C2=A0 SerialNumber=3D1234567890ABCDEF
> C:* #Ifs=3D 7 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
> A:=C2=A0 FirstIf#=3D 0 IfCount=3D 2 Cls=3D02(comm.) Sub=3D06 Prot=3D00
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D02(comm.) Sub=3D06 Prot=3D00 Driver=
=3Dcdc_ether
> E:=C2=A0 Ad=3D87(I) Atr=3D03(Int.) MxPS=3D=C2=A0 16 Ivl=3D32ms
> I:=C2=A0 If#=3D 1 Alt=3D 0 #EPs=3D 0 Cls=3D0a(data ) Sub=3D00 Prot=3D00 D=
river=3Dcdc_ether
> I:* If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3D0a(data ) Sub=3D00 Prot=3D00 Driver=
=3Dcdc_ether
> E:=C2=A0 Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:=C2=A0 Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:=C2=A0 Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:=C2=A0 Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 3 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:=C2=A0 Ad=3D83(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:=C2=A0 Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 4 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:=C2=A0 Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:=C2=A0 Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 5 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:=C2=A0 Ad=3D85(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:=C2=A0 Ad=3D05(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 6 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D42 Prot=3D01 Driver=
=3Dusbfs
> E:=C2=A0 Ad=3D86(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:=C2=A0 Ad=3D06(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
>=20
> Signed-off-by: Victor Fragoso <victorffs@hotmail.com>
> ---
> =C2=A0drivers/usb/serial/option.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 45dcfaadaf98..4ba3dc352d65 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -2262,6 +2262,11 @@ static const struct usb_device_id option_ids[] =3D
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ USB_DEVICE_INTERFACE_CL=
ASS(0x2cb7, 0x01a2, 0xff)
> },=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Fibocom F=
M101-GL (laptop MBIM) */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ USB_DEVICE_INTERFACE_CL=
ASS(0x2cb7, 0x01a4,
> 0xff),=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Fibocom FM101-GL (laptop MBIM)=
 */

It looks like your mail client wrapped long lines; you'll want to
resend with a "preformatted" option or something, or use "git send-
email" to make sure the formatting doesn't get screwed up.

Also, are you at all able to give hints in the comments about what kind
of ports these are? AT? GPS? PPP? etc?  That's usually described in the
driver documentation or in the Windows drivers themselves.

Dan

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver_info =3D R=
SVD(4) },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ USB_DEVICE_AND_INTERFACE_INF=
O(0x2cb7, 0x0001, 0xff, 0xff,
> 0xff) },=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Fibocom L71x *=
/
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ USB_DEVICE_AND_INTERFACE_INF=
O(0x2cb7, 0x0001, 0x0a, 0x00,
> 0xff) },=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Fibocom L71x *=
/
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ USB_DEVICE_AND_INTERFACE_INF=
O(0x2cb7, 0x0100, 0xff, 0xff,
> 0xff) },=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Fibocom L71x *=
/
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ USB_DEVICE_AND_INTERFACE_INF=
O(0x19d2, 0x0256, 0xff, 0xff,
> 0xff) },=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Fibocom L71x *=
/
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ USB_DEVICE_AND_INTERFACE_INF=
O(0x19d2, 0x0579, 0xff, 0xff,
> 0xff) },=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Fibocom L71x *=
/
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ USB_DEVICE_INTERFACE_CL=
ASS(0x2df3, 0x9d03, 0xff)
> },=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* LongSung =
M5710 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ USB_DEVICE_INTERFACE_CL=
ASS(0x305a, 0x1404, 0xff)
> },=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* GosunCn G=
M500 RNDIS */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ USB_DEVICE_INTERFACE_CL=
ASS(0x305a, 0x1405, 0xff)
> },=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* GosunCn G=
M500 MBIM */
> --=20
> 2.34.1
>=20
>=20

