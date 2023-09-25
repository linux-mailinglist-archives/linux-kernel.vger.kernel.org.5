Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2DF7ACF7C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 07:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjIYFbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 01:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjIYFbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:31:21 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AE8FB;
        Sun, 24 Sep 2023 22:31:13 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 17AE5320095C;
        Mon, 25 Sep 2023 01:31:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 25 Sep 2023 01:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695619869; x=1695706269; bh=+I
        pDiZzF3DKExTv5IVzORzCKYeVAxi82DUbw/6rDpoA=; b=aT8WwluRKgTf7xUkPe
        ezbA6eGetjjg1AuUB5740howO/AF5R4PcU8RPwCFrQ0C+MPCBbnnl2An3Hu1i63X
        ePHr0JSPg4aTB7ceUUKURxGIoOJFwWXpuUj3c15wMw/YxHZcRt/cJCQezWoNBtxR
        PE34NX19bPF7iv09gt8SssTfaGpIrmFYFozoowO8xuEvcres3fr+SgebUlPNQqqe
        cVctYgEiluhoLaGHIyvr/zlneNStvfeHTLR77Gq7ExDLCLUWmDWDPR8LFArw9wj2
        pshOrwbkCb9yuvdGeC5vVFhkj1sXIlVJOIu9rqeIVwsXW42hwkPc2nowuMvG79aY
        30sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695619869; x=1695706269; bh=+IpDiZzF3DKEx
        Tv5IVzORzCKYeVAxi82DUbw/6rDpoA=; b=pCef46apQXaNghIR4qvNaltwCw+mk
        A9aaUZQhh75W0NNt0W/bXe2FPxMH1dxqYViRz4IFnsQ0EJcHT//t4E6ek9bLryhJ
        3sAVG5fBZ9AQcLBLGaRyoqrN8r9hreBSCFROlLPAyDao3i+Ovrt2diqOOs+yofE8
        EZ6CUL/1acJ+/Cnj0ij5EDVs6DpmpFZyo3otpWGd42NepQge9XYrloGkFAOm3jz/
        F3mubBsDO0EEFXbbbAi6C3FPpk3jqaJFdOuZ9jzX+tuzjTQwg8ul7K0CGXrIlDlg
        hJ752ub6ZNt1ly//5ZeDL9Anm5vHB99AfIjBO4dX880e5HlzQUsv+YvDQ==
X-ME-Sender: <xms:HRsRZcBaSqCBnNuYFTBSJGOLIjlYlcEVwZdx-_suWnLIMj7ThxfqOg>
    <xme:HRsRZeg_J34cEe4hf2eJL4uVQlg2BTkzwv02W2T7YfGyBP3YOEB3kemfXAhMgcuI5
    5cMakM4zvCj46tWve0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelfedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:HRsRZfn9YAt9FoUe_xO_a7LL_YndwZxsgn_sDoEF6cFh-6I_GZtsXA>
    <xmx:HRsRZSxF6VC570ke1drf123QT3e2Am3W4mKKOkAgfTJtSJmmE1NbfQ>
    <xmx:HRsRZRTASzDOpi74H28-lWzBaJtS8riiBMulrH_QcSByh_CXdiO6FQ>
    <xmx:HRsRZSSUAD40TOx1MDmpPJyqunnzboUukpGGhZovFW_rwpY61jD4uQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 27B4FB60089; Mon, 25 Sep 2023 01:31:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <c1ab31ae-97ec-4630-818d-06cd37ea3d86@app.fastmail.com>
In-Reply-To: <20230925010449.GB7231@dragon>
References: <20230829-for-ml-tqmls10xxa-v2-test-v2-0-b1da63785b25@ew.tq-group.com>
 <20230829-for-ml-tqmls10xxa-v2-test-v2-6-b1da63785b25@ew.tq-group.com>
 <20230925010449.GB7231@dragon>
Date:   Mon, 25 Sep 2023 07:30:48 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Shawn Guo" <shawnguo@kernel.org>,
        "Gregor Herburger" <gregor.herburger@ew.tq-group.com>
Cc:     "Leo Li" <leoyang.li@nxp.com>, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH v2 6/6] MAINTAINERS: add tqml device trees to TQ-Systems entry
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023, at 03:04, Shawn Guo wrote:
> + Arnd
>
> On Tue, Aug 29, 2023 at 11:27:02AM +0200, Gregor Herburger wrote:
>> Update file entries for TQ-Systems Layerscape modules.
>> 
>> Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
>> ---
>
> I do not have a branch for this file, so you may want to send the
> change to Arnd directly.

The MAINTAINERS files can usually go into the same branch
as arch/arm/mach-*/ and arch/arm64/Kconfig changes. If you have
nothing for that, merging this one along with the corresponding
arch/arm64/boot/dts changes is also fine.

We used to have a separate branch just for the maintainer
file updates a long time ago, but they rarely cause conflicts.

Whichever way you end up doing it, please ensure that the person
sending the pull request or patch addresses it to:soc@kernel.org
cc:linux-arm-kernel@lists.infradead.org to make it end up in
patchwork, otherwise I'm more likely to miss it or expect that
I'll get it as part of the normal pull requests.

     Arnd
