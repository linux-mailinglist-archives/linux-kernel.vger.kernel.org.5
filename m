Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C55F7BEA09
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378087AbjJIStU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjJIStS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:49:18 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF88FA4;
        Mon,  9 Oct 2023 11:49:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A9B65C038C;
        Mon,  9 Oct 2023 14:49:16 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Mon, 09 Oct 2023 14:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696877356; x=1696963756; bh=Zu
        QSty1Pr0GQ8WuUZ7cqBdd8ZxfEBZARJmLRVgF8JZ4=; b=fk0Tv96EG1V2AQn1Et
        oHX9+9c/bY5b/vjYHzpTGX6UemRqi/eJk1e2ebK09HfWNYdIZU+PePgvXbhSO0WA
        hNj+9Pn3R77lnHcgR5B+P/E4RsIoIIMvvSpF/zRKuJh2pS5G0yVFgsIYdO1RIHeJ
        5QSBC24K57fDxrbyy4puRJ+Yxvg/47xGfir83CRjHUb+T3XyfHxmYpmfqntiwabY
        ScMPfq8tL5CadsRGvzvFKyHiEsCU8ajzG8z4A594I/FFZTmvCqIeC/xeQMBTWfxF
        m6cOlEsN7ixiDgZM+G+MZ9hg59k2jHCjvJFCvzJHt9QTXrsfxFhjmJ1Ee18OJNhv
        SB4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696877356; x=1696963756; bh=ZuQSty1Pr0GQ8
        WuUZ7cqBdd8ZxfEBZARJmLRVgF8JZ4=; b=evFDh5Vhid6JOiNGwfRbb/saBzJJ7
        aVnGhW+kC9etAuwlM7Vb3IiO4HoFxR2nMZSKZhkKW/ooPldeHsdbA2I8pX7qCWuX
        +e9ItiuRkpPHt8etHnioHaBD+by6wPV6/W2RD087T2lAIoh/30Yy6Q6MenJo2CRK
        2AHxG7M8EgoF87aN5mqeIkI/etAiQnN6vpwHEC2s4W15Te9IfoVcc+1PEFLg/LfY
        0poV0AoXGOdO4Y4A3G+7zu7Rr7KWSwwRieLk+zV9OUa8quIFTnD8/nH5fUreGTrc
        LvBclGrYU+hU/pxnQuR/4O2zKclpqGmbP4e+h1bd0sPgEn8mTi7ZgKKgA==
X-ME-Sender: <xms:K0skZU8jkPFYVlAed8xFMVr8Bh_5-XGZP0SSnVl43msPzgw2_MiPdA>
    <xme:K0skZcse4rC8Z-JXUnbeqCjm69WC2NX-VFfNclkx8BwAZu2kakSab9ZqkT9tru9Fq
    q76hxwZsfPHoQ9oVvs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheefgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:K0skZaDWddxG98DCY9zZIaLrUt_x4yUr_c13nc5ivaH_HB7bh4Gc4w>
    <xmx:K0skZUeOY51_ggSqH5J4zZS1Gjkj-kCD2g1QjN3L1Q0kf3eegVXkHg>
    <xmx:K0skZZMi72zmg2tNPVNt1NIc_odji6gRg5H9H2jpfHc_JvVRn75y1w>
    <xmx:LEskZdld7rdlhRtAb69C_SXYoCwAqBp7b6YhLjnH343RjCaJsqQfoQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1D4F31700093; Mon,  9 Oct 2023 14:49:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <984853b6-b246-454e-828e-abd6ff3076d5@app.fastmail.com>
In-Reply-To: <87jzrvbyl2.fsf@BL-laptop>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-6-gregory.clement@bootlin.com>
 <hu5ksk2gw7zbbeiwi4unfo242qm2wfn36bpgea5inlamn4kqrf@magwi4w7gp3x>
 <87sf6pcebd.fsf@BL-laptop>
 <53050bbd-6a46-470d-9764-c83b8588698e@app.fastmail.com>
 <20231006164019.GA4040344-robh@kernel.org> <87jzrvbyl2.fsf@BL-laptop>
Date:   Mon, 09 Oct 2023 20:48:54 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Gregory Clement" <gregory.clement@bootlin.com>,
        "Rob Herring" <robh@kernel.org>
Cc:     "Serge Semin" <fancer.lancer@gmail.com>,
        =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        "Paul Burton" <paulburton@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Vladimir Kondratiev" <vladimir.kondratiev@intel.com>,
        "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 05/11] dt-bindings: mips: cpu: Add I-Class I6500 Multiprocessor
 Core
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023, at 17:32, Gregory CLEMENT wrote:
> Rob Herring <robh@kernel.org> writes:
>> On Fri, Oct 06, 2023 at 12:48:03PM +0200, Arnd Bergmann wrote:
>>> On Thu, Oct 5, 2023, at 16:51, Gregory CLEMENT wrote:
>>> 
>>> I don't see any good solution, they changed their name and
>>> ownership too many times. I would actually revert back the
>>> description here to "MIPS Technologies Inc" instead of trying
>>> to keep track of what they currently call themselves.
>>> 
>>> Since we already have both the 'mips,' and 'mti,' vendow
>>> names for the 14Kc, 14KEc and 24KEc parts, maybe we can
>>> just go back to 'mips,' for all cores past the mti era
>>> rather than trying to date and geolocate each of the
>>> classic cores as one of 'mti', 'img', 'wavecomp', 'tallwood',
>>> 'mips' 'cipunited' etc.
>>
>> I would reserve 'mips' for anything common. Much like 'riscv' is only 
>> for things based on RiscV specs/standards.
>>
>> I would use 'img' here if we know this was designed/implemented by 
>> Imagination.
>
> If there is no objection I will use 'img' then.

Ok, let's do that then. With this modification:

Acked-by: Arnd Bergmann <arnd@arndb.de>
