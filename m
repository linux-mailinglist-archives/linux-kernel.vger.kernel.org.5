Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4DC7B6AD0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbjJCNpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjJCNpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:45:11 -0400
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A2BAF;
        Tue,  3 Oct 2023 06:45:08 -0700 (PDT)
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 0AB63284EB5;
        Tue,  3 Oct 2023 15:45:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
        s=gen1; t=1696340707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YIUunqd+c5UpYHtGa5Tn8EaHMNG2948xhcFZxPEyyYc=;
        b=Mh1poRY3SriytHnq4LBOTlGr/d77RxtZ5RMpe1mtWAsO5c40s2PyCE8IS6KDFQBUQ3cUV1
        tVzFmUpWO5rSpZQ/s5iDiF7r55D/tncbPUgRgaKcNqLdbcqshjnYBIqTRqXObx9qMLL5qR
        Mnj3WxO48fu1eNn6gxHQXZ6EcysN7s0=
Received: from localhost (koleje-wifi-0029.koleje.cuni.cz [78.128.191.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: karelb)
        by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 7515A441AC5;
        Tue,  3 Oct 2023 15:45:06 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 03 Oct 2023 15:45:18 +0200
Message-Id: <CVYULJSWIJHC.61H4AAIMA9I4@gimli.ms.mff.cuni.cz>
To:     "Markuss Broks" <markuss.broks@gmail.com>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Henrik Rydberg" <rydberg@bitmath.org>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
From:   "Karel Balej" <karelb@gimli.ms.mff.cuni.cz>
Cc:     =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: Re: [PATCH v2 0/5] input/touchscreen: imagis: add support for
 IST3032C
References: <20231003133440.4696-1-karelb@gimli.ms.mff.cuni.cz>
In-Reply-To: <20231003133440.4696-1-karelb@gimli.ms.mff.cuni.cz>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>

I am very sorry, I wanted to use a different email address for sending
than for commiting so that the message would also reach people whose
email providers have more strict requirements on sender authentication
(such as Google), but it seems that I have made a mistake and confused
git altogether.

I will fix it in a possible v3 after I receive some feedback or I will
resend it before it gets applied and I will make sure to properly test
the setup then.

My apologies,
K. B.
