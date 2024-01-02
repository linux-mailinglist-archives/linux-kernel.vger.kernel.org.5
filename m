Return-Path: <linux-kernel+bounces-14005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A07E38216C3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 04:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30184B20EFB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777AAED4;
	Tue,  2 Jan 2024 03:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="M+hlsmwV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4mzICWGb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB4120F9;
	Tue,  2 Jan 2024 03:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id BD4A33200CCA;
	Mon,  1 Jan 2024 22:55:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 01 Jan 2024 22:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1704167725; x=
	1704254125; bh=xtu5fnYjiNRMAjboSlP/RYM4DJQBVcWuSfRSYWtS7Ig=; b=M
	+hlsmwV6Ot1lbuzgVo8WDSd/F690g+htk9q9v8KRFns1RQXKO29KsA0TStUK2kkQ
	LBBi4NTqtgy8ELWYKsOggEPez9yqErfrHs293FtFJhcxIWHlKUA5NfR/7W1FKM/t
	DSIun06sCHDBaqyd9yM6AHnH9qyQ3zn9paRUi7KzoMz0Yt3yOsXOGLFkgxSCDuL/
	dLs7hFOef0z9PhJD9RcMT7wKzrT659QPdpFwNZuMi9hie9jtWh3gB/XI2O/6RfCB
	PTWimKDosgkI0LB8Njv3LURoWKgz21nKZgvD/5uxQto0ylUTxElrcpkI9nvQXEWD
	dWIGdu6V7Jovab2qTzITg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704167725; x=1704254125; bh=xtu5fnYjiNRMAjboSlP/RYM4DJQB
	VcWuSfRSYWtS7Ig=; b=4mzICWGbr2/Ghz4dtdjxN3mXUqAF9gKenc/1zZwJHtPB
	mHQtoeb+AgGS6LTzs0qKH0IIB3sXVHbRbi9K153gvwbXKHdVPtq7wVC6uDOc/Oje
	FIy2yijP2yNwXZgapE7qrJqZzBu8wZdOLFzNrsnC8KAdZXEkhRBCdpAWbVh+NyRt
	PvNv9DqcQV/3Ltsv8XqW8o8dNVN02fzm4x/D1lzB1Z157aTj3pqIgDVoV4zKx4Hs
	m874+pEaetrGbrJiP98bfQeJgxBUt2OyI5ET4UZVYG7IZN+g//LuG/b+ankDz5dA
	1od7EuUdBCcGSmi7cmou5TacKt0G/knDQRNmGaos4Q==
X-ME-Sender: <xms:LImTZYYGub6MV00vuUJfSdbZrLX66npZFnkn_T7-4mme1LGJoi7N3Q>
    <xme:LImTZTZHIvDOf0LU-oVuVqyTJdhBq8JsOQD_wWYLReAvfaR_2dzdudSgfXJt28K7K
    Jm3kd1YUTsmgTru2E0>
X-ME-Received: <xmr:LImTZS8uu3srXsyZ7v1KoJ1S3hEihe6hkbI-Q08DwkHOKFs8GSAjXhVZxdDNIW9hS-qV1vyXHefb8rBvwUOgvNXFPFV3Eux6Vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeguddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeuffevveeufedtlefhjeei
    ieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:LYmTZSpQaHQMhjLL1ubJrHdfhJE6pYWgyOxNmT-raeZdg84SQoegTg>
    <xmx:LYmTZTqia9dfCvoydY9hsd5H4rWjMMpttyVqQQab8tOpefrVQXUtaw>
    <xmx:LYmTZQTL8saVIzbLm6ddByOgjb9Oi1IL-gWG_C8FhvqGUFm8RnAM7g>
    <xmx:LYmTZUDp4Luo-GJB4SsBGhYSt3DEHSwfA4t6Sj4x8PCQpWvj7g_jqg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jan 2024 22:55:22 -0500 (EST)
Date: Tue, 2 Jan 2024 12:55:19 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	adamg@pobox.com, stable@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Tobias Gruetzmacher <tobias-lists@23.gs>
Subject: Re: [PATCH] firewire: ohci: suppress unexpected system reboot in AMD
 Ryzen machines and ASM108x/VT630x PCIe cards
Message-ID: <20240102035519.GA46261@workstation.local>
Mail-Followup-To: Mario Limonciello <mario.limonciello@amd.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	adamg@pobox.com, stable@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Tobias Gruetzmacher <tobias-lists@23.gs>
References: <20231229035735.11127-1-o-takashi@sakamocchi.jp>
 <af04e964-28b9-4c31-a2e2-93d8410b5e8b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af04e964-28b9-4c31-a2e2-93d8410b5e8b@amd.com>

Hi Mario,

On Fri, Dec 29, 2023 at 08:30:00PM -0600, Mario Limonciello wrote:
> On 12/28/2023 21:57, Takashi Sakamoto wrote:
> > @@ -3527,6 +3534,45 @@ static const struct fw_card_driver ohci_driver = {
> >   	.stop_iso		= ohci_stop_iso,
> >   };
> > +// On PCI Express Root Complex in any type of AMD Ryzen machine, VIA VT6306/6307/6308 with Asmedia
> > +// ASM1083/1085 brings an inconvenience that read accesses to 'Isochronous Cycle Timer' register
> > +// (at offset 0xf0 in PCI I/O space) often causes unexpected system reboot. The mechanism is not
> > +// clear, since the read access to the other registers is enough safe; e.g. 'Node ID' register,
> > +// while it is probable due to detection of any type of PCIe error.
> > +#if IS_ENABLED(CONFIG_X86)
> > +
> > +#define PCI_DEVICE_ID_ASMEDIA_ASM108X	0x1080
> > +
> > +static bool detect_vt630x_with_asm1083_on_amd_ryzen_machine(const struct pci_dev *pdev,
> > +							    struct fw_ohci *ohci)
> > +{
> > +	const struct pci_dev *pcie_to_pci_bridge;
> > +	const struct cpuinfo_x86 *cinfo = &cpu_data(0);
> > +
> > +	// Detect any type of AMD Ryzen machine.
> > +	if (cinfo->x86_vendor != X86_VENDOR_AMD || cinfo->x86 < 0x17)
> > +		return false;
> 
> Maybe it's better to use X86_FEATURE_ZEN?

Indeed. We can use it under the condition branch for CONFIG_X86, like:

+       // Detect any type of AMD Ryzen machine.
+       if (!static_cpu_has(X86_FEATURE_ZEN))
+               return false;


Thanks

Takashi Sakamoto

