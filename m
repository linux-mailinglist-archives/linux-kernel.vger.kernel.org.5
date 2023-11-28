Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6B37FC416
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345755AbjK1TPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344875AbjK1TPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:15:46 -0500
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D67D66;
        Tue, 28 Nov 2023 11:15:52 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailnew.west.internal (Postfix) with ESMTP id BA6E32B0011C;
        Tue, 28 Nov 2023 14:15:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 28 Nov 2023 14:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701198946; x=1701206146; bh=cY
        OZQ38Ev4q/vOiKyAZOmafzVAVzihcQxUYgmkqmmR8=; b=Ie5DH8OhUPUS8UVIYu
        QAQsUPJ9SijS+yZOJ+Ohi5LFlA/p5S0YB+RXSN7Zt+8en9SveUsXAp0VAi9gPp8P
        4qBjAis12AEHiocvAYrct/whzkR3nM/jTjS+80fKg6ofcyl9g2180gHC8xn5h5Xx
        RZ02k/gjuafT82Wyt8+ZEUrQHDODZtstEhyqAleHaD4hwrIJ/2Z0cpJGgJrFaEYi
        /WIHpOkDZ4HpEAO2A42u6wQ4+PBEqMYeoNKiIIY+1W7mAMSdFPISV5EXVE4uPl4M
        dN2YdCgajG7AXSN6ecG42gj7eTm/Mf5mrT1vBSqjkdtSVnPQXV6oksOnPgtpAFkx
        azjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701198946; x=1701206146; bh=cYOZQ38Ev4q/v
        OiKyAZOmafzVAVzihcQxUYgmkqmmR8=; b=YC5rg7c9WsU6h0PUBFWCMz3/MqM/q
        F6rk44aqQmxnOCPdnvXRroqJetVbIFMTF2/hnU784IvyOxENW/Y4S7CGDVwmRQds
        igPUY7H3pPRbuiPZbcqjXSgOQ7im8U1yHi1bxQdcO/x53kLD1yXh6Q/Kbj4nkhWg
        7P7U6qgzXJ/DMm0vbRDyKYqzIIGr1RBErTT0N/GbVGalvYhAbPneZY2XzzQOBTRh
        WZJBuK5430+bnChoZg8+8+Ih5ZuwcjNLWDur+MDFRknahYlaG17xc/xPXRQJ+Z/v
        k5pdVR3usMcL2tx7TZfVBdPTjMD3N2FsO3RkBmy8SxmvQaO766x+Lvs3g==
X-ME-Sender: <xms:YTxmZemDR2Zp5BW8BSnqqAJUlILJmN4imWjRRsC0DKqoaS1ja1KJrw>
    <xme:YTxmZV2cuL1rSVyZDC99LEJg9VubIpekL5NLFI8KbBR6cJIijLFXm3ydLpioXO_0G
    c-M1Nt-kkAtYlOlhg>
X-ME-Received: <xmr:YTxmZcp5MmfhDXwerCoDXicQiD6Fcc3am3PXmAlvvlxU9tg4xDvuLoZaggR8K4uyaeul9A7-1bBZDfhNTApxF0fhVrBjnREGBJWBdwrF29oikqrGUiEJ02Ry19I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnecujfgurhepff
    fhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeftdffueduheehud
    fhgefgfeejlefhteegieetveeiieehfedvheduieefvdefudenucffohhmrghinheplhhl
    vhhmrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:YTxmZSnDBAGMNn0wrHlKa4ShF4GfCH1zBOmiSCrSXLV1U-8wdqjy2A>
    <xmx:YTxmZc2ybWod_0nq7HjvY4tpPGXravJUC-sNOGlBcz3b6tKMy6lKpA>
    <xmx:YTxmZZvrO_uTXm18VGI5udd6Mi7G-iDhIZYTGxIcvuwA1986V62mwA>
    <xmx:YjxmZX_Qrp3OfPKr5yKsoaOYZrrB65tYaj5VIehQJLR-JzuMhsYoAv2BgUw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 14:15:43 -0500 (EST)
Date:   Tue, 28 Nov 2023 13:15:41 -0600
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     ndesaulniers@google.com, andrii@kernel.org, nathan@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, steffen.klassert@secunet.com,
        antony.antony@secunet.com, alexei.starovoitov@gmail.com,
        yonghong.song@linux.dev, martin.lau@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, trix@redhat.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, devel@linux-ipsec.org, netdev@vger.kernel.org
Subject: Re: [PATCH ipsec-next v2 3/6] libbpf: Add BPF_CORE_WRITE_BITFIELD()
 macro
Message-ID: <qcjvpbuhnj3jwbc5gb5c3tmla7scwpxuwgcqgfbvc6ewwjej3j@o7t3f6wacwps>
References: <cover.1701193577.git.dxu@dxuuu.xyz>
 <ed7920365daf5eff1c82892b57e918d3db786ac7.1701193577.git.dxu@dxuuu.xyz>
 <20c593b6f31720a3d24d75e5e5cc3245b67249d1.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20c593b6f31720a3d24d75e5e5cc3245b67249d1.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 07:59:01PM +0200, Eduard Zingerman wrote:
> On Tue, 2023-11-28 at 10:54 -0700, Daniel Xu wrote:
> > Similar to reading from CO-RE bitfields, we need a CO-RE aware bitfield
> > writing wrapper to make the verifier happy.
> > 
> > Two alternatives to this approach are:
> > 
> > 1. Use the upcoming `preserve_static_offset` [0] attribute to disable
> >    CO-RE on specific structs.
> > 2. Use broader byte-sized writes to write to bitfields.
> > 
> > (1) is a bit a bit hard to use. It requires specific and
> > not-very-obvious annotations to bpftool generated vmlinux.h. It's also
> > not generally available in released LLVM versions yet.
> > 
> > (2) makes the code quite hard to read and write. And especially if
> > BPF_CORE_READ_BITFIELD() is already being used, it makes more sense to
> > to have an inverse helper for writing.
> > 
> > [0]: https://reviews.llvm.org/D133361
> > From: Eduard Zingerman <eddyz87@gmail.com>
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> 
> Could you please also add a selftest (or several) using __retval()
> annotation for this macro?

Sure, I'll take a look.

Thanks,
Daniel
