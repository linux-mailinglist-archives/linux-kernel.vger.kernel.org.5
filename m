Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D939C7EE655
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345356AbjKPSCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKPSCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:02:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ABF192;
        Thu, 16 Nov 2023 10:02:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECFCC433C7;
        Thu, 16 Nov 2023 18:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700157722;
        bh=kyf6uYIa2rKHq1Ny4L/ltR39Hvgb2Q0eYVoy7wnSfW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jz12So7K03qo27YzyGcWgKCJVOjhaBxRj/biyvEQQQqRZnnfXe52aQWt9rfWzb9VW
         7yVFrKm+ueq94KciM0FGMvV0CK2kb76pwOlSbu3M89cf2wuR8WtNL+rFy2e/Jdjt6J
         8aIgfoWTx7wPQEU0SbTTubiOCG85rXL8gZ3VDSybmQUEv7bhj0YrL/H3Psej9DnW9Q
         Eutn5dbj8M83rrs6IiVio9uyzrCirF8IFfew5FYV364+7VWXOoUS1Dggwo7UoTNgdA
         1lNZpFHce3wmiiPx1qTRZy4TfNaClAq+NwDOw82Wltxb9Olqpi5DIbBNpVKOd6gTAg
         AA5ihaA5M/GpQ==
Date:   Thu, 16 Nov 2023 13:02:00 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Serge Hallyn <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Henning Schild <henning.schild@siemens.com>,
        Andrei Vagin <avagin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH AUTOSEL 4.14 2/4] binfmt_misc: cleanup on filesystem
 umount
Message-ID: <ZVZZGEYCi0exWsbK@sashalap>
References: <20231106231728.3736117-1-sashal@kernel.org>
 <20231106231728.3736117-2-sashal@kernel.org>
 <202311061605.4B418CD7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202311061605.4B418CD7@keescook>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 04:05:46PM -0800, Kees Cook wrote:
>And just to be clear, please drop this (and the binfmt_elf change) from
>all -stable versions, not just 6.6. :)

ack, thanks!

-- 
Thanks,
Sasha
