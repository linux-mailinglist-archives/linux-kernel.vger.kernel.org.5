Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9447E83EE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344987AbjKJUeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjKJUea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:34:30 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6661727;
        Fri, 10 Nov 2023 12:34:27 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6ABCE3200A72;
        Fri, 10 Nov 2023 15:34:23 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 10 Nov 2023 15:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1699648462; x=1699734862; bh=rP
        L0L5KUQk+cK1C+LNi4k7UhNNxLQnP3AQ29ohc2S6w=; b=f8oAnehgRh8PEq3eUs
        MniZgBbSOw79+dfkbvIH2lSHxPQb1kc66mslSpgxKLgFAWxNfHlLGp63tfI85+XG
        v2NXInvz/ckYKVXc9DLPqt+oojxW0rWBL4Pfw1/gm1fQdmybY8aeVeIKBQLgWBWR
        l52GjrvxdweYlnxxeWqH3jpixrOECZ8AhU00uPa/DCBmK0+M1qy7UNuqUbKFUZ/i
        7HNzqqBX3jbcmG+VvEkew/oDSn3LWvQpM03OtNVRtmGGpFG5IBSb92EONUwK0on7
        V/wLnPowXF9ZgKZF4P+60Cb45jy5TYDEoWNbBHSMFjaRJQ8swZR58rHn/sdbB0Cr
        UOBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1699648462; x=1699734862; bh=rPL0L5KUQk+cK
        1C+LNi4k7UhNNxLQnP3AQ29ohc2S6w=; b=ZqYdLONN2AWLGVBIM6Unf+gcUhyZA
        F6Krek5NBsE7W3fMVLkwbSrKKrMtLs3QRiR2tUMhGU7FFHMxQ404xX+0O1kosxsL
        v0NFf2HdQrxg5sjMu1zsDLzHyiDuJ5xveelcdR3Ay8HCY+kh0ZajB+qfVBLAOIXY
        sVcX7SA7rNWY95zpWvl2ECYu2NcU6WAw9zGCACsXHdKuPzCu6FL9+qQ9o95pq0lC
        1NhrkP6lT/86hm7uGH8dpXlHGh+8eyA/5z7LDSqczXaexk7NvXlECJv2yzTsDjB1
        Yslmn5yBT/Elivl65FuOgiBxCk7eX5PfRITV5VvOAkhOBfytOUww7QTCg==
X-ME-Sender: <xms:zpNOZd4U1bdb6Kw47cIAfGFDfKgaOCnfWT5HIDP4fDUjNqIUfZtdcA>
    <xme:zpNOZa5yF7_7gn4Z7XFMe6a2nkOWpDO2RmkSyO2UPNuxokch9KgPEvgeIWH9daL-i
    aWuH3pg1HkM-yL1qDI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvfedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffegffdutddvhefffeeltefhjeejgedvleffjeeigeeuteelvdettddulefg
    udfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:zpNOZUeAzAFjQ85JPd7Y9S02tIxPiMUKFQTuE2OSCqxc7KU2rG4naA>
    <xmx:zpNOZWLUqZcRGHYj1YMQsIVBHlcx9tVYVf72e7aGf00LITN-xTStTw>
    <xmx:zpNOZRI-uypRNJGJLNyC8NBw6Q89rCcXdbSJvG0-_Fg7JCpFdrxMXg>
    <xmx:zpNOZfi3GONl_F_o8RLZcOXDHLOLMQM7IRvnXedPjnv4JbjFml6qNQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 93796B60089; Fri, 10 Nov 2023 15:34:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <6cce1756-db32-4486-96d0-320d08569fbf@app.fastmail.com>
In-Reply-To: <20231110194827.122045-1-charles.kearney@hpe.com>
References: <20231110194827.122045-1-charles.kearney@hpe.com>
Date:   Fri, 10 Nov 2023 21:33:21 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     charles.kearney@hpe.com, "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Conor Dooley" <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] ARM: dts: hpe: BUG: Correct GXP register ranges
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023, at 20:48, charles.kearney@hpe.com wrote:
> -		ahb@c0000000 {
> +		ahb@80000000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			ranges = <0x0 0xc0000000 0x30000000>;
>  			dma-ranges;
> +			ranges = <0x00000000 0x80000000 0x20000000>,
> +					 <0x40000000 0xc0000000 0x3fff0000>;
> 
> -			vic0: interrupt-controller@eff0000 {
> +			vic0: interrupt-controller@4eff0000 {
>  				compatible = "arm,pl192-vic";
> -				reg = <0xeff0000 0x1000>;
> +				reg = <0x4eff0000 0x1000>;
>  				interrupt-controller;
>  				#interrupt-cells = <1>;
>  			};
> 
> -			vic1: interrupt-controller@80f00000 {
> +			vic1: interrupt-controller@f00000 {
>  				compatible = "arm,pl192-vic";
> -				reg = <0x80f00000 0x1000>;
> +				reg = <0xf00000 0x1000>;
>  				interrupt-controller;
>  				#interrupt-cells = <1>;
>  			};
> 
> -			uarta: serial@e0 {
> +			uarta: serial@400000e0 {

Are these the actual addresses in the datasheet or
did you just make up a mapping?

If you have two separate address ranges, that would
typically indicate that there are two distinct ahb
instances that should be represented as separate
bus nodes. With the new mapping, it looks like all the
devices using vic0 are part of the same address range
as vic0, which also indicates that they might
be on one bus.

If this is a single ahb instance with multiple distinct
address ranges, I would expect that you need to adapt
the dma-ranges as well.

     Arnd
