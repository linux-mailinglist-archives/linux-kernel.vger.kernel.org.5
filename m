Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E113E78888C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbjHYN01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245197AbjHYNZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:25:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F1A2713;
        Fri, 25 Aug 2023 06:25:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34B8F67C03;
        Fri, 25 Aug 2023 13:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997ECC433C7;
        Fri, 25 Aug 2023 13:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692969917;
        bh=UWKoyH/ywoyEF1ufRO9IJIoct8WGx46f3VYxGV7tHtY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jrci8MsPoCv3jV2FO1hz1jPOCPoAfjCyg64m42dDOQEN88vcrfeDPGR0bWOmnkD/J
         9Y/soZzXfhgZLHRPOVC+Ao7Q9k4l7h3MeiezmsTkAxJ1Wi96iH2eIpNHOAAnXEC2Yj
         Nu1o/XKO8GDzHYOoGkN2/5GQxBI04aX3T3v9+/LYSGG5mfmuRj9eRCTGrr7gp7I4Wt
         ROUa62ayWkJLq894ZTKadvTswcyJOvZQXM3xOhGbBb6tpWfp4XYzaJ/d67gf6MFxao
         bDpySWkv0e3TJhgag/Txayq0sxYyqGk7CeRp/CDlqSSP/T7sE/FhpQlY7EVIs/sYoJ
         NFgOlwjr0trmQ==
Message-ID: <0f2be47c-7c35-ec64-7eba-41fdc49af8ca@kernel.org>
Date:   Fri, 25 Aug 2023 15:25:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH -next v2] rv/include: set variable 'da_mon_##name' to
 static
To:     Yu Liao <liaoyu15@huawei.com>, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        liwei391@huawei.com
References: <20230823020051.3184953-1-liaoyu15@huawei.com>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230823020051.3184953-1-liaoyu15@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/23 04:00, Yu Liao wrote:
> gcc with W=1 reports
> kernel/trace/rv/monitors/wip/wip.c:20:1: sparse: sparse: symbol 'da_mon_wip' was not declared. Should it be static?
> 
> The per-cpu variable 'da_mon_##name' is only used in its defining file, so
> it should be static.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307280030.7EjUG9gR-lkp@intel.com/
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
