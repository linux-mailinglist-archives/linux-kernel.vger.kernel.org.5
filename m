Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D237DBE7B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjJ3REo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjJ3REl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:04:41 -0400
X-Greylist: delayed 486 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Oct 2023 10:04:17 PDT
Received: from relay.mailchannels.net (gt-egress-001.relay.mailchannels.net [199.10.31.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4986A9;
        Mon, 30 Oct 2023 10:04:14 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 89E3C4C3D18;
        Mon, 30 Oct 2023 16:55:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a298.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1079B4C3BE3;
        Mon, 30 Oct 2023 16:55:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1698684943; a=rsa-sha256;
        cv=none;
        b=2CXHmmycSwYVIhoJzBRjEghs5y4qN+dM+Esljemt1HIPg5/6I7WtTltVbs6NmjVPk6KiU0
        FpFnyrNvWMin1OV7lBQBNyjygUbMJMhZH7byDu2D3P06ZwyZumMwPmP/K2C6zLwJt6RS5Z
        1si2APyxQws2ZdRGYQu7mCAaxod+NvUiwDJurXw23eGh06YL/Qe9iVEvduztm4SScbLTWJ
        te8By5di/55RgEiUoy4ZRLTMbXegZ+5KcdsyGR2pNSrVpZg7F1QEPz4xv1RFYJ7HWNrHIm
        EeXzem74Cd5sjbEhrzM4r0IsT5a18GXhrPP9T1q5GCUz+nNbluVKoGq2NAuYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1698684943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=yeWInyf9RC5QASJ328kWPFhyjq9Bvnkp3cAVgJZB9XM=;
        b=q6WEpp+HPm1nyOwEL5zJH/EPuhKjtBP9XM4SO/KxnjmI/ibWaIA4tQEIUkv+cpDktIEmv1
        7vTmp+v+/AwQdBoHxAldinWD2GuKa+XbPX4rAe73+0Ok3pEsyZ1LK2Xt1xOI1QxLshW4XT
        yG4cpfHfQLIi34TGL4TpAcRZSTF+geXOmULwIubOdxERq7htiTp3laa6yMxaFnuvz1Wh+a
        NhpN1tssF4S/AKjCLAQ/xRIRPixgF7Rq9l3uLWYQ0H8CuyeURtrwSzNjBcy8ao8pBdsUTr
        u5Ov/MJCBqRslElp8iC6F32hfbRsc6FmFvvX1cf9cqg7B+5JNXuqSCuXGh/9tw==
ARC-Authentication-Results: i=1;
        rspamd-86646d89b6-ckfgs;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bottle-Whispering: 4ae5ec7e59508ca9_1698684944770_746902069
X-MC-Loop-Signature: 1698684944770:32499628
X-MC-Ingress-Time: 1698684944770
Received: from pdx1-sub0-mail-a298.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.232.215 (trex/6.9.2);
        Mon, 30 Oct 2023 16:55:43 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a298.dreamhost.com (Postfix) with ESMTPSA id 4SJzsg06S8z11v;
        Mon, 30 Oct 2023 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1698684919;
        bh=yeWInyf9RC5QASJ328kWPFhyjq9Bvnkp3cAVgJZB9XM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Z+JbvFkyQRZtyUncgVFxZMNUs9G45Y4IMC9OkchLlhWLFRHpHfzFrxjMlM+iX9mCt
         B1QXY243c8l2p9L+OFF/lDNRBYjqvhFj73XrZ92no/zJypywl94LdRbIUdtZCAmmQn
         d3y3H409U8ZrylXdcuilycy9CmJqGDEXqsPI68D0qWSQRtd7QPWYosTxVQE5u98Rfy
         wm/1IqZTjZDIDO3VI3UcAIrnlomveWiommV2zTGV+oIKH77b1J4oEOmgizpOrqfmv7
         0bEbZECPLe8ocxLKZfTWZOMNP15S2WTJustjcw0mxLizFNoxQELjq3qI/KlGg6Vrec
         oGL6ETX4BDaZQ==
Date:   Mon, 30 Oct 2023 09:55:16 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] refscale: Optimize process_durations()
Message-ID: <ozbrmbywamyfkv3amsf2dfdacwmi25serwhc75h6fpsahklsmo@rm43srgxumef>
References: <bbbab32e3e104bdc2238724a6a4a85e539f49ddd.1698512661.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bbbab32e3e104bdc2238724a6a4a85e539f49ddd.1698512661.git.christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20231006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2023, Christophe JAILLET wrote:

>process_durations() is not a hot path, but there is no good reason to
>iterate over and over the data already in 'buf'.
>
>Using a seq_buf saves some useless strcat() and the need of a temp buffer.
>Data is written directly at the correct place.

Makes sense.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
