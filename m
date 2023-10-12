Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BE57C6AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377335AbjJLKWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbjJLKWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:22:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9136BA;
        Thu, 12 Oct 2023 03:22:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3F0C433C7;
        Thu, 12 Oct 2023 10:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697106168;
        bh=jkOf6zlY3dtr1U4Md02h/jP/g3KZE/yyKcHPQfjlK0s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PK339P2K3E9NTHi9ntN7LB8zDL2x6BFpQ1YBKfS8tf3ZHOXhUbhgIZGcM2oH4BUIc
         /WdG8pTlVKjRSppRGO4qtheNOjjUxHW5zfagcn6GZfqZIi+RCjyEmO/Kq6ilca7Y8E
         AaFRljZJsQ3GTN9T1AG8lpSvOh6QNKb0qpZJGqzxy7o/O6dSx5uqGCkneqopWt26J5
         idsRi3Zj+kD1MgoVDVZ7ya3CcnkOxUzbV9a8DzuYKMvBoBQXozZaUG3a5db/errAv6
         AKj9HxBJkmGwU4L5MBh4xq01NvQuoHygWU2nkEeTLMXPU+3A6m1AON6/dfEBQbQqqW
         TiCmpkyaNcfdw==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Cc:     stable@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20231007131042.15032-1-ansuelsmth@gmail.com>
References: <20231007131042.15032-1-ansuelsmth@gmail.com>
Subject: Re: (subset) [net PATCH] leds: trigger: netdev: move size check in
 set_device_name
Message-Id: <169710616600.1174986.4498192566234857598.b4-ty@kernel.org>
Date:   Thu, 12 Oct 2023 11:22:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Oct 2023 15:10:42 +0200, Christian Marangi wrote:
> GCC 13.2 complains about array subscript 17 is above array bounds of
> 'char[16]' with IFNAMSIZ set to 16.
> 
> The warning is correct but this scenario is impossible.
> set_device_name is called by device_name_store (store sysfs entry) and
> netdev_trig_activate.
> 
> [...]

Applied, thanks!

[1/1] leds: trigger: netdev: move size check in set_device_name
      commit: e0e29e434cdca9705eb420b3f26928444fa559f6

--
Lee Jones [李琼斯]

