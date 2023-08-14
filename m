Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A748377B5B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjHNJpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbjHNJot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:44:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E3EE8;
        Mon, 14 Aug 2023 02:44:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D91864BAD;
        Mon, 14 Aug 2023 09:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12359C433C7;
        Mon, 14 Aug 2023 09:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692006287;
        bh=1IIoZalSUlUVq1bz07HvHg9BkKMalLCKTeYFZqc2Q0I=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=hhZ60FB3CaWlVqy+pQY5bWk6JpkcMNFM4AAhUpF4r99KNCH/KI04H2qXlETgHDSp6
         ZU+oJ9sgW0nFt5bNuhiNeP9MlbRTTkz2jqM9qhFulwBcc9g+Mh5E+XpR0pYjTJC04X
         PIBxXEJd8QbY6Gc81JNEJG9Z1JRu6Ws92q6ram2V9tNTkHzkpTXU5nMi2UjXgfYKMV
         XjrwHTYvgdILpgou8pXhDYAhNiqphKWKrM1WCCLgODWmTvQgg1XQD6/DKcBJXHNS3l
         yth0V72a4cw4AndvSRcaRru8wqrijwP9YYiZmuRkEe+dbrQFd9a/1GUw2iNQ6GEkdg
         C8G5kJI0+ClEA==
Date:   Mon, 14 Aug 2023 11:44:43 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Aaron Armstrong Skomra <skomra@gmail.com>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        benjamin.tissoires@redhat.com, pinglinux@gmail.com,
        Joshua@Joshua-Dickens.com, jason.gerecke@wacom.com,
        stable@vger.kernel.org
Subject: Re: [PATCH Wacom EKR Battery Fixes 0/3] 
In-Reply-To: <20230725221936.123775-1-skomra@gmail.com>
Message-ID: <nycvar.YFH.7.76.2308141144130.14207@cbobk.fhfr.pm>
References: <20230725221936.123775-1-skomra@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023, Aaron Armstrong Skomra wrote:

> Currently the ExpressKey Remote battery will persist indefinitely in
> /sys/class/power_supply. Remove the battery when we stop getting
> reports from the device.
> 
> Also remove some unneccessary code and make an EKR struct name more
> descriptive.

I have now applied the series. Please look into your mail setup -- the 
patches in the series were not part of one thread, but separate.

Thanks,

-- 
Jiri Kosina
SUSE Labs

