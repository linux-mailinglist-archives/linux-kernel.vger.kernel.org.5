Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFC77F5AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjKWJJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjKWJJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:09:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581C3D43
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:09:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716E2C433CC;
        Thu, 23 Nov 2023 09:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700730551;
        bh=MGeralf9ybdkNXfCDd+XvD4Agot2pAJ6J1WgdjYYR0c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FvNHvLufpD6/CN1Pxbx/u3k5XSOf0hl4FzfIf/3QU34ZsnkRQ2hK6CGpFcA3IUcH8
         jhH7JVV44zg2eQ7EiVJlDIenWEg9yBGJO5i+SqyxddFnZ5NMvLvmK9DWxCqg2zJIhi
         KQzVay/4GXNGtNF8NTYDUS7As483rJhClEXFKljhohWNqycpH3Xg6wfHzX63jaNWs0
         2VDh1tUZK2bJDMsEhtjHc2E2v5UZmzochMCOdAx4TTp72ufg+c9VNgQYz+b+t0PeH+
         xEF3fFgxF8GpoK7bl6gI65a22nOc0GeaD+docy+HZ4/Tq4Z7kqcuia8iyh+aj+ejBW
         z9sYNShM8A4Lw==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231122205418.2482076-1-robh@kernel.org>
References: <20231122205418.2482076-1-robh@kernel.org>
Subject: Re: (subset) [PATCH] dt-bindings: leds: Fix JSON pointer in
 max-brightness
Message-Id: <170073054914.1187160.15361411561980210800.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 09:09:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 13:54:17 -0700, Rob Herring wrote:
> A valid JSON pointer should begin with a '/'. The json-schema package is
> lax on this allowing either form, but that's changing in new versions.
> 
> 

Applied, thanks!

[1/1] dt-bindings: leds: Fix JSON pointer in max-brightness
      commit: 2dc0a14846ecf85fb4de29be186581f008d197dd

--
Lee Jones [李琼斯]

