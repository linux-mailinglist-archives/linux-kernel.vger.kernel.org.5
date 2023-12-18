Return-Path: <linux-kernel+bounces-3678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E855B816F79
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14ED01C23399
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAB737867;
	Mon, 18 Dec 2023 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="N/XaTCLp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tYC0tK7a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB221D147
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 168F75C00F3;
	Mon, 18 Dec 2023 07:50:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 18 Dec 2023 07:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702903830; x=
	1702990230; bh=bmsqqJeIAUf+XP0ART0QYJLK60XqmBNUAlO8Smcs/NA=; b=N
	/XaTCLpHp699rU1sbmc7RsHjmuXN/qRrVfr8DDqoak+99OSWs/R4PQ2AE4KNMi+4
	j1hC4NxNb94KKR6PGmwMhS3IdZfHy0UhuTm56wMZd8pzw4rEl+LwPuqo4wI1+spM
	LWrkvywVYqUHrOMDvGp/8rVGquMNNvuimAu1qlgMd82W5FE1AwSKsa8CZSQ9txfz
	IRapoyMlgjtg8YpHfjXU9tDqymomwifuqmIbt6jGkpFosvutCb04rT3JJy5WId3Z
	KCXkIaJfVIH/ynzaxStx2770g28G/t7kTum0/l+tinbFR/MMweCLBIuT36Cl58sL
	UgbOGc9l4Vr9mfkubV+nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702903830; x=1702990230; bh=bmsqqJeIAUf+XP0ART0QYJLK60Xq
	mBNUAlO8Smcs/NA=; b=tYC0tK7atZeLDqneS7XsdOUOWPpfTntA0ZVpMztcjlUA
	7b8KDr6xBBFqiDsj0tU1uN9lJHzFebDFp/1ocg/lo8kFcmHoWGwzvvdQ0VYPb8R3
	NsA9vV4uFXcmOMEigOnPnbF4X3Oo5NgOwQRCtLulbzaqPeOmS9D7Wgp5OGIGSjGm
	TDzJmtbT14ujoEBq2tXtUy4ot+E0K0iMAod12EDbi4IEJOw5R/zQ0xXavn5lWLUb
	NY/eifK7NRjOKYRyifK/CG0jSvzFNGmMeZDTxXnj8MgHyBReINzgUg0OWNc6DpWM
	Kpgel+mda7c53U+MW4OX/JT18yVdbAGE4puclZnjZg==
X-ME-Sender: <xms:FUCAZVznSmdObSmGZaThOZDUm3cdPxj8iWb1B2NFSS-lvGHGT6zGvg>
    <xme:FUCAZVRGh58Ybkgr4lLZIZT4U_I2HioQHzAtdT9Fm0sfS5Z6bmVN3GfPZkUGDsN34
    cHjEOSmxDocux59hIk>
X-ME-Received: <xmr:FUCAZfXBmBo38v1A5BJ-lTeeeV5q78fH5LqwrsmmgsheuEdghJ1PxgQyTXUXHYD0fl4LTjYwr8TjVkzBkqiWHFska8KIAM66pIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeuffevveeufedtlefhjeei
    ieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:FUCAZXgfDBrv0J-fewvJwSovwKa-cvG1l7dVg4OuDAjPAunJU8J_3A>
    <xmx:FUCAZXD6UkpnW63zuHQ5W4sWn7rEN7tB-ISImNaECefs2XaaEdP3Vw>
    <xmx:FUCAZQLee7JegDn4CpOSlePppN7K0VYQBb9sv28BSPW9XAye0BY4HQ>
    <xmx:FkCAZc6hyhJN0j_kRK6Af5sxJXqvXDkuxj9OlGKSZ1hMxWOJgIAnZQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 07:50:28 -0500 (EST)
Date: Mon, 18 Dec 2023 21:50:26 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Adam Goldman <adamg@pobox.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 7/8] firewire: core: detect model name for legacy
 layout of configuration ROM
Message-ID: <20231218125026.GB46034@workstation.local>
Mail-Followup-To: Adam Goldman <adamg@pobox.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20231217103012.41273-1-o-takashi@sakamocchi.jp>
 <20231217103012.41273-8-o-takashi@sakamocchi.jp>
 <ZYAZPRt79Qa1YPS0@iguana.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYAZPRt79Qa1YPS0@iguana.lan>

Hi,

On Mon, Dec 18, 2023 at 02:04:52AM -0800, Adam Goldman wrote:
> Hi,
> 
> On Sun, Dec 17, 2023 at 07:30:10PM +0900, Takashi Sakamoto wrote:
> > -	ret = fw_csr_string(dir, attr->key, buf, bufsize);
> > +	for (i = 0; i < ARRAY_SIZE(directories) && directories[i]; ++i)
> > +		ret = fw_csr_string(directories[i], attr->key, buf, bufsize);
> 
> I believe this is incorrect. If the attribute is in the first directory 
> searched, the loop will continue. The second loop iteration will set ret 
> to -ENOENT because the attribute isn't in the second directory. Then 
> show_text_leaf will return -ENOENT even though the attribute existed.

Exactly. It is a bug.

I think we can solve it by aligning the pointers of directory in reverse
order within the array, like:

```
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index d3fc3270a00b..adae3268291f 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -326,13 +326,17 @@ static ssize_t show_text_leaf(struct device *dev,
                directories[0] = fw_unit(dev)->directory;
        } else {
                const u32 *root_directory = fw_device(dev)->config_rom + ROOT_DIR_OFFSET;
+               const u32 *vendor_directory = search_directory(root_directory, CSR_VENDOR);

-               directories[0] = root_directory;
-
-               // Legacy layout of configuration ROM described in Annex 1 of 'Configuration ROM
-               // for AV/C Devices 1.0 (December 12, 2000, 1394 Trading Association, TA Document
-               // 1999027)'.
-               directories[1] = search_directory(root_directory, CSR_VENDOR);
+               if (!vendor_directory) {
+                       directories[0] = root_directory;
+               } else {
+                       // Legacy layout of configuration ROM described in Annex 1 of
+                       // 'Configuration ROM for AV/C Devices 1.0 (December 12, 2000, 1394
+                       // Trading Association, TA Document 1999027)'.
+                       directories[0] = vendor_directory;
+                       directories[1] = root_directory;
+               }
        }

        if (buf) {
@@ -342,8 +346,11 @@ static ssize_t show_text_leaf(struct device *dev,
                bufsize = 1;
        }

-       for (i = 0; i < ARRAY_SIZE(directories) && directories[i]; ++i)
+       for (i = 0; i < ARRAY_SIZE(directories) && directories[i]; ++i) {
                ret = fw_csr_string(directories[i], attr->key, buf, bufsize);
+               if (ret >= 0)
+                       break;
+       }

        if (ret >= 0) {
                /* Strip trailing whitespace and add newline. */
```

Thanks

Takashi Sakamoto

