Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023867E7161
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344995AbjKISZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344978AbjKISZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:25:56 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374BA3C02;
        Thu,  9 Nov 2023 10:25:54 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77a453eb01cso73704485a.0;
        Thu, 09 Nov 2023 10:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699554353; x=1700159153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFlmUurTmdF3Ze+l+tPdbyjpboJib8D5PD5pQg1Zezg=;
        b=Q74s/ESVEKVhShAEBeco5e/uTFbTbb3jNvnU04JuLDfgTP0pHSnDBmi1iPMaQ8pAdX
         xRGKMj4Xn3aEWaSQlIaTtYx7NxEaEgqGHOztmXURclddWOPJVto/saRYgXYIwGs0P63k
         jvmgwuuUsZvcnZ8xidDc13spogvL1F0zq/qJ32ZZnMIJBemEdZgWXKICbf1Oc/7XcmL6
         WqNcVqGqOmz8di1nkiwR2V7iOjLpQR8+j6W0Y1fZvdihMU8zY8JPmsqfl/kLEmI1sbyc
         bLQBN63/q1yhUvGUUm5A5lAJy4NNvcN3Pt6rUWtrjmD9gaX68KBywakcJ2V0mNOVArIJ
         en6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699554353; x=1700159153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFlmUurTmdF3Ze+l+tPdbyjpboJib8D5PD5pQg1Zezg=;
        b=Lhr9rH0goIRvmsx6QCG2ybjsdn2lkB2pFE0F4qW+YMhuuENutS7v6yCK8Ba9Nu9hUe
         HphW9M0RayB96IX4YcsP7Kl5oAkSnwa+/dDFCJe69+LGQ/T86PJ6MlwiWvvi0pPKhakR
         qcx200ExEPAfB93TChJ4eG4Oi2nXSuHxr1o/UgPygUFKPPAIPfYTsShhtQIgoZuLbcqv
         5+wQsVnv9+Klo7MvEga2ZiDvVPqsw1+nzFZS+yfi8yFbzRzbfYDJHKN1AcZ97o1VonSp
         22GDkQBIGP/lcwonx90SUeLQ9tG8JzVp1U8fpnLH3c9dsBulguuteeZypWINJPmsebkY
         Y6sw==
X-Gm-Message-State: AOJu0YzrYAI3Fb5yZhUqZ7oFmDPGaOLKnwH9H221xHBM+UohktK6hwGd
        PvHJlK/G8j2R4XHzHuAM6Wk=
X-Google-Smtp-Source: AGHT+IHxf9dzAw7F40nPNzjrdvXQ0JuKaR7wFW3r4MjCPKh7xrSriX75HbG8O8nnLoQlgeSlAnx/2g==
X-Received: by 2002:a05:6214:2687:b0:66f:b847:71b7 with SMTP id gm7-20020a056214268700b0066fb84771b7mr6545621qvb.25.1699554353252;
        Thu, 09 Nov 2023 10:25:53 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id pr13-20020a05620a86cd00b0077407e3d68asm83506qkn.111.2023.11.09.10.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:25:52 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2E39227C0054;
        Thu,  9 Nov 2023 13:25:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 09 Nov 2023 13:25:52 -0500
X-ME-Sender: <xms:LyRNZdAYu2WkcnnAxfbzaWKa4rbFwO1D70fIMGVwUFJHZEGyh52m6A>
    <xme:LyRNZbiMqvAqUI19YhfLYw2Kyb4y9wLjt4UaeR36XC9adYqLC2s0RFuzdscIPU4PS
    OZ40QIr9lLhj1MUBA>
X-ME-Received: <xmr:LyRNZYmSC_Q63e9hs01bF8cVMEMh86NUqLhbrhfmpCbA4HIBt6SAHgG62Gc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvuddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:LyRNZXzmw3cQ_AIigsuj6AQ_xH1YsxXLOb76iEp5mNAPlKJgD4XYVw>
    <xmx:LyRNZSRPED6WnXavmqx48M1sEi-qrmBUiSnEXCVC0MKn1TB9SLzKJQ>
    <xmx:LyRNZaamIsK1_hXardp-NDm3ERRZofJGZeqdxuhyBtTxfC099tvYfw>
    <xmx:MCRNZeoKyyy6XBs7QqVRrRb9BlpB2N-sx3QnIDEhFwLEcXLOFtmhwA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 13:25:51 -0500 (EST)
Date:   Thu, 9 Nov 2023 10:24:23 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     paulmck@kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>, j.alglave@ucl.ac.uk,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, palmer@dabbelt.com,
        parri.andrea@gmail.com, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, davidtgoldblatt@gmail.com
Subject: Re: Fw: [isocpp-parallel] OOTA fix (via fake branch-after-load)
 discussion
Message-ID: <ZU0j1z26ki1dsPpB@boqun-archlinux>
References: <b1634b24-4541-49c5-867c-7f24292a27bb@paulmck-laptop>
 <20231105230859.GH8262@noisy.programming.kicks-ass.net>
 <d18e0ce6-db9e-4590-a7ab-15e27b2c33f4@paulmck-laptop>
 <20231107095745.GD19790@gate.crashing.org>
 <bf18e3f7-f8be-4b11-b348-b784420bda16@paulmck-laptop>
 <ece7680c-630e-956d-ad9f-10614afa84a4@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ece7680c-630e-956d-ad9f-10614afa84a4@huaweicloud.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 05:25:05PM +0100, Jonas Oberhauser wrote:
[...]
> > 4.	Semantics of volatile.	Perhaps the current state is the best
> > 	that can be hoped for, but given that the current state is a
> > 	few vague words in the standard in combination with the fact
> > 	that C-language device drivers must be able to use volatile
> > 	to reliably and concurrently access memory shared with device
> > 	firmware, one would hope for better.
> 
> 
> Is it really so bad? I think the definition in the manual is quite precise,
> if confusing. (volatiles are visible side effects and must therefore have
> the same program order in the abstract machine and in the implementation,
> and that's pretty much it).
> 

But I don't think there is any mention on whether current volatile
accesses can be excluded from data race, or whether a volatile access
on a machine-word size natually aligned object can be teared or not.

Regards,
Boqun

> There should just be a large explanatory note about what it implies and what
> it doesn't imply.
> 
> 
