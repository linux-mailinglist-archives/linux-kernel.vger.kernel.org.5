Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DDC7D45E1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 05:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjJXDWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 23:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjJXDWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 23:22:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990FF10C9;
        Mon, 23 Oct 2023 20:22:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBCBC433C7;
        Tue, 24 Oct 2023 03:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698117741;
        bh=wM4Q7H3OavnQ2yEHWK7SQy8Yee4IvRBdIbXvUqtz4jg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=g8zLe5kWhlLOGKrl9Mm7y/s1MTAjKukW/u7ZF4M3P5olPgNkYX13oSPzwfQGVMV93
         TWuKX+oUU9Erw2gYS7wDYb35GJWWOtTUmhX9GKUl3kMKOQjpVDZmgsvKPpL7UjpYoE
         dYdCkx2HJKAoC6yp5De2c49n+FopqLHl+89AMrTt9+Lgkl0Ws0TCJSQCF+lfEUL+G7
         aBdYd0vPRQCxpZ+GNAPdE49/sO9LJ6dzVwAvHnsHj608jJ4lDv9hADsFSxpahriVYW
         11KEXWxqMeV6QdtIen01cv/OzFpg3XqQUjNggpNOt0D3Ll9FT7UBX/UyFQm/+XHq0w
         xadigELmjGAWg==
Message-ID: <9431003c15a024f7fb4ec28609b16975.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230420103805.125246-1-john@metanate.com>
References: <20230420103805.125246-1-john@metanate.com>
Subject: Re: [PATCH] clk: Allow phase adjustment from debugfs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     John Keeping <john@metanate.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
To:     John Keeping <john@metanate.com>, linux-clk@vger.kernel.org
Date:   Mon, 23 Oct 2023 20:22:18 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting John Keeping (2023-04-20 03:38:04)
> For testing it may be useful to manually adjust a clock's phase.  Add
> support for writing to the existing clk_phase debugfs file, with the
> written value clamped to [0, 360) to match the behaviour of the
> clk_set_phase() function.
>=20
> This is a dangerous feature, so use the existing define
> CLOCK_ALLOW_WRITE_DEBUGFS to allow it only if the source is modified.
>=20
> Signed-off-by: John Keeping <john@metanate.com>
> ---

Applied to clk-next
