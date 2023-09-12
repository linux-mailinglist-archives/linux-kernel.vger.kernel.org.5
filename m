Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FC779D0DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbjILMRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjILMRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:17:30 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EE110D2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:17:26 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id DE28032009CA;
        Tue, 12 Sep 2023 08:17:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 12 Sep 2023 08:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1694521044; x=1694607444; bh=zdQ95R9qhufZ8XMZwT5PBjE/0
        Wn+mksn9sXWFZ7BPjk=; b=JmheIHwBamzDf6JNHD6Dpaf/+uOrhdfwx4YazDGt0
        sbfaXavFFjZqPKrvAd+FmMifihjEvzxvHjn8na0Y4CDq6Qbqu5bo6DRkDZbnU3KI
        KKvVLLZqixbX52Rx14Z616Vn3gUFMCmA/1oicx78JIMKZBAkOheal/8KCo3V/wd3
        Jpr4nBq/ykNgEffg4aTphkJ4MPYU1VKhYP6wUjWNxBul6LvF513iR8i4t50zdLOH
        2GyOFBW8cRj6so8fRlJH+GOMomYiDdvyFJrOw6lERDUDZK4/2um2//LhRhkdjTgx
        QJ4WXdXIxhip8yYP3ZBf7mDoJWdhARFVfXsff9j94h6Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694521044; x=1694607444; bh=zdQ95R9qhufZ8XMZwT5PBjE/0Wn+mksn9sX
        WFZ7BPjk=; b=xSKVZy3Gb/u3sTyQmkykpqotgxKY8k3gqH+0zl7wQi2U54n2i6u
        9XprARGpOFtCNQX7hV0Lwf3x0EFXT44iB3tqpYrp4gDdn8NKkyiuRPbocik7nUhD
        OLfTWb60OnikiPSmBylJbAsD/od6jMK7UzawEr6A5AxqM6OXoTKYcjM70fwhRqBg
        PvT6sLksrHXcocWbGdx5Q+/cWdXuRwiLK0+gFfiYYZ0An/UZM9DkNm1PZx4pxC8T
        RMwF46tT4b6F0qUucmjbpIOcPqi+pQpnzAhPZdfyGeKJlEYoTe7VUiLpzfKn5oCc
        QZwJ1XmyKmrxO+lShna0EiQLZyA+Nk02QNQ==
X-ME-Sender: <xms:01YAZb-8_L8HXM0zpQf9v6JvUQy5FfREDE-WMqtqSu7GttI_tCqktg>
    <xme:01YAZXsTOrp0oI_J2RaeuTguLVe0-AYl5KtK8wnd-cr7RHduYKP4wAGivYGaZ_NBd
    vhmxHzgDGQ_8OcsDGU>
X-ME-Received: <xmr:01YAZZAl_w55rzeRaKOtCu2jOuXn333KIWHCGq91d24qmXw_BMw4RJs_2cC6mAHBS52QSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkedttddttddunecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepteevheelteeggeffjeffjedtveegueegfeet
    gffhhffgieevgffhueevgfejkeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:01YAZXfKBWQ4ocnwOoI77_29FK6VoG9H-PJStDtaDQRn3VR9W6iv0Q>
    <xmx:01YAZQPjVd4jSLTz06BuzgE2-5RTQF_ovOMwxoQVDMlin07Bg_4CLA>
    <xmx:01YAZZn2MDYVxEKAKYAZK3JBTUIpCgHfLJeHic7I2iq0I00ralRBTg>
    <xmx:1FYAZckHR_bCGdydbEkYedOBZu7nbzi6JktaTVwHt_kO0rNkmSxNBg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 08:17:22 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 8875310940A; Tue, 12 Sep 2023 15:17:19 +0300 (+03)
Date:   Tue, 12 Sep 2023 15:17:19 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Christopher Schramm <linux@cschramm.eu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 5/6] x86/sev: Add SNP-specific unaccepted memory
 support
Message-ID: <20230912121719.6i6ojvbb6ptw2i2l@box.shutemov.name>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
 <cover.1686063086.git.thomas.lendacky@amd.com>
 <a52fa69f460fd1876d70074b20ad68210dfc31dd.1686063086.git.thomas.lendacky@amd.com>
 <101c3910-a164-4b4c-9474-8743dc6d1199@cschramm.eu>
 <905c359a-19d6-6cba-4540-92d03b936525@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <905c359a-19d6-6cba-4540-92d03b936525@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 11:50:15AM -0500, Tom Lendacky wrote:
> >  From a quick look at
> > 
> >    [PATCHv14 9/9] x86/tdx: Add unaccepted memory support
> > 
> > it actually seems very similar for INTEL_TDX_GUEST.
> > 
> > Ideally UNACCEPTED_MEMORY would not assume EFI either, but the
> > implementation actually clearly does.
> 
> @Kirill, is this something you are interested in having as well?

Unaccepted memory is an EFI feature I don't see how UNACCEPTED_MEMORY can
be untied from EFI. If there's other (non-EFI) environment that has
similar concept, sure we can try to generalize it beyond EFI.

TDX guest is only runs with EFI firmware so far, so depending onf EFI and
EFI_STUB is fine for TDX>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
