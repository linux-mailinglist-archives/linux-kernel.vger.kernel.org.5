Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F18E7B7A17
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjJDIcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjJDIcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:32:48 -0400
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D42E1;
        Wed,  4 Oct 2023 01:32:42 -0700 (PDT)
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 8DC02285078;
        Wed,  4 Oct 2023 10:32:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
        s=gen1; t=1696408360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RdpatbGoKHvRonzK6UU9+LbdnKe8p7FuVMX0hk+KgI4=;
        b=q0k9ovatWGBsQRTK3zHnf8/b8cDrXupvCcw1uIZEx+rS3idQoedBLFG550hrQKySG+MZGm
        vyAMIDN68u40IbIay1D6elzx4j4TdIoggB71DQgweMeF+bHYpL7ooJvUe0M9GkhOHuCkt/
        DNQvDe12PiJEROjy1udGAfvuQtLG1GQ=
Received: from localhost (visitor.troja.mff.cuni.cz [195.113.29.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: karelb)
        by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 6AD99441AC5;
        Wed,  4 Oct 2023 10:32:40 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 04 Oct 2023 10:32:53 +0200
Message-Id: <CVZIKW399928.15QFSHKLY0CSN@gimli.ms.mff.cuni.cz>
Subject: Re: [PATCH v2 2/5] dt-bindings: input/touchscreen: Add compatible
 for IST3038B
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Markuss Broks" <markuss.broks@gmail.com>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Henrik Rydberg" <rydberg@bitmath.org>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
From:   "Karel Balej" <karelb@gimli.ms.mff.cuni.cz>
Cc:     =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        "Karel Balej" <balejk@matfyz.cz>
References: <20231003133440.4696-1-karelb@gimli.ms.mff.cuni.cz>
 <20231003133440.4696-3-karelb@gimli.ms.mff.cuni.cz>
 <b14654a4-7cbc-4027-8456-73efe214498d@linaro.org>
In-Reply-To: <b14654a4-7cbc-4027-8456-73efe214498d@linaro.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Krzysztof,

On Wed Oct 4, 2023 at 10:09 AM CEST, Krzysztof Kozlowski wrote:
> On 03/10/2023 15:34, karelb@gimli.ms.mff.cuni.cz wrote:
> > From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
> >=20
> > From: Markuss Broks <markuss.broks@gmail.com>
>
> This does not look right. Please apply it to your tree and see the
> result. You cannot have two From fields,

I am aware of this problem and I have explained it in a follow-up
message to the cover-letter, which should have reached you too - was it
not so?

The patches themselves should be fine though, so I plan to wait for some
feedback and fix this either in v3 or in a resend before application.

Best regards,
K. B.
