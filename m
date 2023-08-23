Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A239E786394
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238772AbjHWWtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjHWWsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:48:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A40AA8;
        Wed, 23 Aug 2023 15:48:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DD7063DAF;
        Wed, 23 Aug 2023 22:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8596C433C8;
        Wed, 23 Aug 2023 22:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692830923;
        bh=WRutnQ/VR4DwgCui2CG7Dh0frc4pFMrEN8EHlbOTNlY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gIVkH3EVML/7ZkGFxIROVywPd7CViHGSMBofdZ/0DzcmSSU+5RugnMh1aleDiRrgV
         MPkQM1pI5afRMxE4uY6kC13ghMUNC3qpsbi3ncmn95Er3tl+OKjKU8wZ13/nOg1MGs
         kEpGYuznwea2QSVzIZ64zCr+THVkYO6abV+0bXpOYJNc9u/pKjzKohmTNusZRjOlV1
         5R2pni1RmXfHJfqMKAPWfSCMuYRtUSstGhck9aRxWqgbO8syV3W3yKg5pyBOHanOxd
         AHXLZ7H0jflYPwWq8PhUkCMuHiqxcFMeHyN/Eg7J4l9431z1Bd1ov4R/G5k1Lt9Fdx
         DL5vuGdHHX+5Q==
Message-ID: <521559814e3a4c4990618886b6fd7b8a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230802064100.15793-2-mike.looijmans@topic.nl>
References: <20230802064100.15793-1-mike.looijmans@topic.nl> <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.37b21939-e4ca-460d-8656-25f90de74f6b@emailsignatures365.codetwo.com> <20230802064100.15793-2-mike.looijmans@topic.nl>
Subject: Re: [PATCH 2/3] clk: lmk04832: Don't disable vco clock on probe fail
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        Mike Looijmans <mike.looijmans@topic.nl>
To:     Mike Looijmans <mike.looijmans@topic.nl>, linux-clk@vger.kernel.org
Date:   Wed, 23 Aug 2023 15:48:41 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2023-08-01 23:40:59)
> The probe() method never calls clk_prepare_enable(), so it should not
> call clk_disable_unprepare() for the vco.clk in the error path. Fixes
> a "lmk-vco already disabled" BUG when probe fails.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---

Applied to clk-next
