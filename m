Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E167F0AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjKTDUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjKTDUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:20:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85A0192
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:19:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AAFC433C7;
        Mon, 20 Nov 2023 03:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700450399;
        bh=mS+QScR4CYHjpZgCrte4Dp+KllABBfJ6CY+nMOOQ6Vw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OwzuYUWnWzmg0N+phG42U8A1maJOLvivlbjsq2EhTqSbt74HLy3NdQmMqozKwZbeM
         VO6+ZA/xNepf04+rzNo4RaWWxjROm0GOHPsj7u8lFhUujRosj85f/QS6rmuKg9N+78
         V9u2mbQlfrxUNkmtA+XM2sHi+DMqbGHiqHU8rSHrEf3GIjAjipWSFRsjh6jP6EKD6+
         MSJwMHrBNxROHwwO8p2QMewM+o03Q6sjznwxs8LDF60uf0qAHIH+U171cmYFfy/MNL
         xQsCQJ+9sJhNQ/ifBXIfdRJymYvpIZgXstKXu2Cr+0L8QjZ39phM5EPf8rx4Qb8VsP
         qB+0iBCBqp6dA==
Message-ID: <5939cb04-071a-9530-32d4-44fe16d23565@kernel.org>
Date:   Mon, 20 Nov 2023 11:19:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip adding a discard command if exists
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20231114212414.3498074-1-jaegeuk@kernel.org>
 <4a0e1c6f-12c4-f3dd-bb26-4bf0aee6be4b@kernel.org>
 <ZVQwz5ubx9LojzEf@google.com>
 <236866a2-41b0-2ad0-db77-4c377367c80e@kernel.org>
 <ZVel0bHLlg4IizJ_@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZVel0bHLlg4IizJ_@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/18 1:41, Jaegeuk Kim wrote:
> Not sure other cases yet.. let's do one by one, since I hit this in real.

Sure.

>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thansk,
