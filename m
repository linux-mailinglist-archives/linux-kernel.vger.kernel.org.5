Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613AA79C115
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjILA0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 20:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjILA0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 20:26:45 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05281377B9;
        Mon, 11 Sep 2023 15:57:43 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id F06373200918;
        Mon, 11 Sep 2023 18:56:11 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Mon, 11 Sep 2023 18:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1694472971; x=1694559371; bh=Ea
        pXY/dHk/L+KfdsJnZIXaxdmbC/YxZh0fcsusxzVFI=; b=Z1qW4isTxdg0I62aD1
        I6xzs2VtaTEAsQ3HsKYDilLUwxksu1tbRY7mkgyromFZzzxkqw2HD1OytTiahXb+
        Nx++gyTMlYhEOXbv5M15Sv3+PtNQihmUsv3dOXcMUtH4uwaQKDG+Ke/WcFaO7JJD
        aWeyNoWEb0IIa0nI/WAbnscDv5AfH0utP2SU6SMXqufpPeS5IhkHAWdMizSCIZK8
        Rz7/9L4qibgjCRoAvPnTFe0cpuOXJ48NBHwsFq99KJKgcmlKi/Uov1iytDlEUxzq
        8+Tp6wiTCdkbuTSw+voRiO9HvyeHG+JWSKYabZ+xsSS3dUAIumWHMwWBCFWYF9mh
        ClIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694472971; x=1694559371; bh=EapXY/dHk/L+K
        fdsJnZIXaxdmbC/YxZh0fcsusxzVFI=; b=yJVLsQbOVAvTKRVKS6v75wpQgMsoT
        9ywUmKRPfsf1BBXCY1CutXWcP7i+S+utGssDMp7J1Two2sJEdzhkuWaz1mMBECld
        BBjrrwYVyp/rU/5zE0a/OfxQFuTohRzT8ONhSZ1v5Obka3Ca+TOmBJq3oMmTjQq1
        8ofvp3OmG0Otplz7RMq7oH75+X95yAahcq9rqtZnPK5yJQ3eowitbf9xw+l+B719
        bVH1NVp76WU/he8clQ/fxPKSUVuyza4XyVwFIszRYV+bcvZIjpynjaYSYnjCipRP
        ukY7Gq9Ls7qeZvo5Xan5Kaf9L3BwiPL1ovkg+VNiCwo5p0iNvkJbR2ciw==
X-ME-Sender: <xms:C5v_ZEpwyEBB74Zm39jhT64htpAlb6MdMT-bXMXlW4cKqlytXz5fXg>
    <xme:C5v_ZKpnaKI4JTufIEfztGy9tX4JHGg_xeZiadJLZl8SM8R6xxeO96G7pu7293XXi
    GKiEJCQuFZAYiD7jWs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeihedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpefofgggkfgjfhffhffvvefutgesthdtredt
    reertdenucfhrhhomhepfdflrghnucfjvghnughrihhkucfhrghrrhdfuceokhgvrhhnvg
    hlsehjfhgrrhhrrdgttgeqnecuggftrfgrthhtvghrnhepteeluefhfeehtdejvdduvdel
    hfffueevteefgeeuhedtiefgtedtheekhfefiedunecuffhomhgrihhnpehurghpihdqgh
    hrohhuphdrohhrghdprghrtghhlhhinhhugidrohhrghdpfhgvughorhgrphhrohhjvggt
    thdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkvghrnhgvlhesjhhfrghrrhdrtggt
X-ME-Proxy: <xmx:C5v_ZJM3r-dc6IffYP6H__wC090VsMK6o19bPReC26my5OUjiXLX6w>
    <xmx:C5v_ZL4n8AvAAM-g_ClsLtVIwL1EW8AyhNcUWsrH0sj9qsY7PP3V4w>
    <xmx:C5v_ZD5kYXz49K8Fj_OGtrvGT6f35vMs4ZRrwW4uTHAdtcKGdgvLDQ>
    <xmx:C5v_ZAyCAZRXV9ddr4oruuG9fD_5ZU-TmNH4hCtm0tQwHvP3F5eNPw>
Feedback-ID: i0fc947c4:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E597B15A0091; Mon, 11 Sep 2023 18:56:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
In-Reply-To: <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
Date:   Tue, 12 Sep 2023 00:54:32 +0200
From:   "Jan Hendrik Farr" <kernel@jfarr.cc>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>, linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, bhelgaas@google.com,
        lennart@poettering.net, "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What the heck is UKI?

UKI (Unified Kernel Image) is the kernel image + initrd + cmdline (+ some other optional stuff) all packaged up together as one EFI application.

This EFI application can then be launched directly by the UEFI without the need for any additional stuff (or by systemd-boot). It's all self contained. One benefit is that this is a convenient way to distribute kernels all in one file. Another benefit is that the whole combination of kernel image, initrd, and cmdline can all be signed together so only that particular combination can be executed if you are using secure boot.

The format itself is rather simple. It's just a PE file (as required by the UEFI spec) that contains a small stub application in the .text, .data, etc sections that is responsible for invoking the contained kernel and initrd with the contained cmdline. The kernel image is placed into a .kernel section, the initrd into a .initrd section, and the cmdline into a .cmdline section in the PE executable.

If we want to kexec a UKI we could obviously just have userspace pick it apart and kexec it like normal. However in lockdown mode this will only work if you sign the kernel image that is contained inside the UKI. The problem with that is that anybody can then grab that signed kernel and launch it with any initrd or cmdline. So instead this patch makes the kernel do the work instead. The kernel verifies the signature on the entire UKI and then passes its components on to the normal kexec bzimage loader.

Useful Links:
UKI format documentation: https://uapi-group.org/specifications/specs/unified_kernel_image/
Arch wiki: https://wiki.archlinux.org/title/Unified_kernel_image
Fedora UKI support: https://fedoraproject.org/wiki/Changes/Unified_Kernel_Support_Phase_1
