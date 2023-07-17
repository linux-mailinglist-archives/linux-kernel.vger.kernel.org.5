Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC497567B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjGQPV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjGQPVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:21:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4A8170C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:21:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E995A610F4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599CFC433C9;
        Mon, 17 Jul 2023 15:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689607214;
        bh=pmHa+uof/omh9/YyLI+lAkXG8CFJh+ryKNfzwo+yCiI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GnyILK+xYovKsbVfNzoWkm9663M6Mcp18LctpBhc0uHXIV9W0VXk8z1f5UTmiT0K3
         gUCuh3yzYqQSxpq55sY9cl8sAsBRxL6y4QWuy+U9Sfhc+cdj5Nyxr+Reud7F9V0Omw
         z5Yc68k6zZSinDmsBlmELbjXozXBtsd7RRt3XOg6yJpgKCuSf6EuGm47o5+ORNweJV
         yEGs7xbyn82Zve0ght6k6L0rHslTw38opZ5O8gQ3sD1p9aktjqXzaJ2/qLDq/kW5Jk
         fl3smMa9rSGLDntzLfiJFqp67kp2DdBmXvxx/MVj8INpzhwDuqFSPruU+BQUcu+Qd8
         +QUmiX+WqOBKw==
Message-ID: <e42cbeb5-e890-c8b7-f1f2-1cc04a340edc@kernel.org>
Date:   Mon, 17 Jul 2023 23:20:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] f2fs: increase usage of folio_next_index() helper
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230717071109.5663-1-duminjie@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230717071109.5663-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/17 15:11, Minjie Du wrote:
> Simplify code pattern of 'folio->index + folio_nr_pages(folio)' by using
> the existing helper folio_next_index().
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
