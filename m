Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4558A811583
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442089AbjLMPDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442067AbjLMPC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:02:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE51BA0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:03:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3F8C433C8;
        Wed, 13 Dec 2023 15:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702479785;
        bh=ERYPWlZcuAsc3JTXR2wiRcqYpvAqlyOmPFSh5X5mKMU=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=OSo1JyPIEEiOqSQkxHZc0rW9gEY26xIxY2pFyOxbAqRhG/rDBaAxtpEvgzIC3a3pt
         BOTZ1qII5VJxtazr9MqP8EACT+Y10dkh0nTg/2zbkGhXa39zOHCp0lS2agt9gVpSUA
         CltxBEF/1zLz9K6yQKhdzCOxewWh1wdpeSegUeTuIg7GJzS/3k3qz+1WtZ7QogvGzF
         xVziHZ9wNt/ymRn/TJmviMnMb+ThIlYT9UCT3XrJ4PtKzjYsjv5K19rJ/CRjLpihym
         bUxdTZmbWd91qtxA4hOgs52zd4GHLQMWjdLK6nitFMxSRK908BKfPZqXp/RqsI97M0
         /RT3giJthg+FQ==
Message-ID: <09db7e8dadfa5d73bdcbf2f6c6af9fbd@kernel.org>
Date:   Wed, 13 Dec 2023 15:03:02 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     davidgow@google.com
Subject: Re: [PATCH v2 1/4] kunit: Add APIs for managing devices
In-Reply-To: <20231208-kunit_bus-v2-1-e95905d9b325@google.com>
References: <20231208-kunit_bus-v2-1-e95905d9b325@google.com>
Cc:     kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-sound@vger.kernel.org,
        "Brendan Higgins" <brendan.higgins@linux.dev>,
        "David Gow" <davidgow@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Kees Cook" <keescook@chromium.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>,
        "Matti Vaittinen" <mazziesaccount@gmail.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Rae Moar" <rmoar@google.com>,
        "Shuah Khan" <skhan@linuxfoundation.org>,
        "Stephen Boyd" <sboyd@kernel.org>, "Takashi Iwai" <tiwai@suse.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 18:09:29 +0800, davidgow@google.com wrote:
> Tests for drivers often require a struct device to pass to other
> functions. While it's possible to create these with
> root_device_register(), or to use something like a platform device, this
> is both a misuse of those APIs, and can be difficult to clean up after,
> for example, a failed assertion.
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
