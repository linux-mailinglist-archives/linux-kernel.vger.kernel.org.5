Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0A97D5EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344728AbjJYAMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344711AbjJYAMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:12:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F19BDA;
        Tue, 24 Oct 2023 17:12:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B67EC433C7;
        Wed, 25 Oct 2023 00:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698192749;
        bh=bA96xsObOn318WvHN3mETfnfCPJHO/rY6j1wJ8ZDbt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tIfhg1R9osxf6Nsb/wJNktEZJQaE7o2tfWoX36gd3usjvtLIvUsQRw1+bLrHIXqE9
         Y/MEiM9pYB3ZRdFyvlKAE3sYKux+RdknhbKkRdUr5MV4J1I6PF1JuCbffwE0rnQz/f
         mZkqjIQvR0A4qexjAnOWFAi/YSuKmk4a6Ase4PgTmlxHaJO0bNR681HM0XQE2BOzF0
         TDOG2mJ2nwIYTJFoDmAf+EcC9X9n5/jFzqohss/gaJMbfdkaghkVHI4eIiisUwkROJ
         EqZ5aAwErFkcq6Th+r+4pRTU4Tav/xpxG0wPxP69eDilXfqlc+WIwkFXocwV+Yo4FR
         YQ2lrWlpsQHNw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, conor@kernel.org, f.fainelli@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, lkft-triage@lists.linaro.org,
        patches@kernelci.org, patches@lists.linux.dev, pavel@denx.de,
        rwarsow@gmx.de, shuah@kernel.org, srw@sladewatkins.net,
        stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
        torvalds@linux-foundation.org, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.5 000/241] 6.5.9-rc1 review
Date:   Wed, 25 Oct 2023 02:12:18 +0200
Message-ID: <20231025001218.376633-1-ojeda@kernel.org>
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Rust, build tested and booted to see the minimal and printing Rust
samples output in the kernel log. Also checked that `rustdoc`'s docs
rendered as expected given the patches included in this set:

Tested-by: Miguel Ojeda <ojeda@kernel.org> # Rust

Cheers,
Miguel
