Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB20798039
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 03:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbjIHBfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 21:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjIHBfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 21:35:18 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D67519A7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 18:35:15 -0700 (PDT)
Date:   Fri, 08 Sep 2023 01:34:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1694136913; x=1694396113;
        bh=20d3p7nggaNeFs2QF0z5nZ1bLxBGS0c6JQr7quxo9mo=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=x3fe5Sy29HYNDlu5kpuXgzXhEzFi/hNI8bZ5Yfb+lyb6LqnorGXBbeASV+DSydnpa
         SZcWFwwQQqAAcVhXpY8xvoXU8DG7jiZhWau0Bgx2fH+uMI8X+nlybZMKHIhXwT66mu
         OEXcndVpYr+ptTKA0XgKz7YQoReUK8PUhg3beVfALzffKK2WPQ1YIimQ2aRp+fEpkT
         E6LsV5HzFnQPi/I/1qN7DOaz/LaIk6YXP0pw6V+20zq00yjNVmenBOQFumSKcpKFM2
         Oj/6XGKkwv2oZ+9a7hdMZTe2Eouc1P8211tGGyKYEZkGCeQauj8WSBqadWAr9K4kUZ
         wB0tb2EP8ATew==
To:     Johannes Roith <johannes@gnu-linux.rocks>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     ak@it-klinger.de, andi.shyti@kernel.org,
        benjamin.tissoires@redhat.com, christophe.jaillet@wanadoo.fr,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH v5] hid-mcp2200: added driver for GPIOs of MCP2200
Message-ID: <87bkedv45j.fsf@protonmail.com>
In-Reply-To: <20230907164121.21092-1-johannes@gnu-linux.rocks>
References: <87ledpvhgm.fsf@protonmail.com> <20230907164121.21092-1-johannes@gnu-linux.rocks>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Thu, 07 Sep, 2023 18:41:21 +0200 "Johannes Roith" <johannes@gnu-linux.ro=
cks> wrote:
> Hi Rahul,
>
> thank you for the explanation, now I got it.
>
> I have added hid_hw_stop and hid_hw_close to my remove function and remov=
ed the
> devm_add_action_or_reset. The driver still worked well.

Glad to hear this worked out. This discussion has motivated me to take a
deeper look at hid_device_remove in the near future to see what can be
done for devices that need to invoke hid_hw_open without needing to
explicitly implement a remove callback.

>
> So, if it is okay for you, I would go this way and generate a new patch.

This sounds great. Excited to see your patch on the mailing list.

--
Thanks,

Rahul Rameshbabu

