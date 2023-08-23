Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB85786391
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbjHWWtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjHWWsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:48:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6687CF1;
        Wed, 23 Aug 2023 15:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F79563DA3;
        Wed, 23 Aug 2023 22:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8E8C433C8;
        Wed, 23 Aug 2023 22:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692830914;
        bh=IhgjCMkYI3n71u3LVYb6mEPmDb3r+oz+bDBe6Sa4pwM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=W2d/MxyJVeSzdKDSMu8I9yhHgONxWP9TYV8bKL8sn/lrtJh0bB3yLl0HjV+9KY55d
         gtFvaJnlRv1vBufV6zXDPRmbpn8/OL5EWqO2hguiv20Bc+7ZLBhDwp5uS4f0agrsqL
         KriURdxLxmrPniovEkMeZCUtGpjuKJETr1Ej1qNNCDV7pkPPWy3eg8pA/+R1ZqM7xn
         MlzADOcR6g38hSi0N6xTlpXaOJLDhNg1LQuDmYq1AhQcpsq5A+3jh2tkHES63PQarY
         44hGk7yIlEsEFAlNh82IVCB6xo3Ah5oLM7FhqUI+4A90akzkKQSFs+EwmjjnEyxKq/
         ao6BPxcvcxkKw==
Message-ID: <fe6fc1b91515cb9a57fef6234cbcf372.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230802064100.15793-1-mike.looijmans@topic.nl>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.05b2cfbe-0414-4869-b825-034b9be5bf9a@emailsignatures365.codetwo.com> <20230802064100.15793-1-mike.looijmans@topic.nl>
Subject: Re: [PATCH 1/3] clk: lmk04832: Set missing parent_names for output clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        Mike Looijmans <mike.looijmans@topic.nl>
To:     Mike Looijmans <mike.looijmans@topic.nl>, linux-clk@vger.kernel.org
Date:   Wed, 23 Aug 2023 15:48:32 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2023-08-01 23:40:58)
> lmk04832_register_clkout forgot to fill in the parent_names, resulting
> in the error message "Must specify parents if num_parents > 0".
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---

Applied to clk-next
