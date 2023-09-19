Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063CA7A67F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjISPYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjISPYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:24:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EF7134
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:24:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98775C433C9;
        Tue, 19 Sep 2023 15:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695137053;
        bh=bSlfL3InP8esNwovMEVZkpK+n8PRuY9C6jFBy0whcuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ezBYdrPnFZZHNR48nydSx8LCp6DQPnsdblGg1zTUvwdNgT8a99/o1b28kLAGbOUuL
         EqAPlprYG8FLl1Uu9i4PAsmCfsTzeebCkXMpOMhzvWkCyJDF6GOKB8ifAevQ+qSEf2
         Beb4hw2KFJdpEzZSjoyM9N5eUeyt12ootKb4H+3DJ8jSvdI4Za5O7dBXrZHB2DxF7h
         JF7ADTVzU1jqBH2omMqSgFLzMqNYoJZxJeqcXeRyVBYKxKjKj2JRFOBC9AkmhO4iK+
         KyVdbsmbz3Qf8j2yCwutOZDCJoYRM5g1YsyWNo3BtNZ9v80TQTiNPSchiqXQqhdOAH
         gftWfYNUqAsBg==
Date:   Tue, 19 Sep 2023 16:24:09 +0100
From:   Lee Jones <lee@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] mfd: max77541: Simplify probe()
Message-ID: <20230919152409.GZ13143@google.com>
References: <20230831185329.70472-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230831185329.70472-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023, Biju Das wrote:

> Simplify probe() by replacing device_get_match_data() and ID lookup for

There are hundreds of ways to "simplify probe()"

Please collect all of these MFD related patches and provide a better
subject line that easily identifies the changes.

For example, I just applied one of your earlier patches as:

  mfd: max8997: Simplify obtaining I2C match data and drop max8997_i2c_get_driver_data()

... but I don't have enough spare cycles to fix them all up.

Feel free to use this description or come up with something better.

Please post them all in one set - else they end up spread all over my inbox.

> retrieving match data by i2c_get_match_data().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---


-- 
Lee Jones [李琼斯]
