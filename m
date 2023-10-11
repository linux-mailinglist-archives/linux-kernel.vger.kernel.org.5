Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749FE7C46E3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344526AbjJKAx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344281AbjJKAxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:53:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A0198
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:53:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9531C433C7;
        Wed, 11 Oct 2023 00:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696985604;
        bh=mj9vvaX08mP1wsFqvNHjipeBW3oiY6bFRx9YYrrtEjY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SQmvVyYtVLEOYvX7+LDjj9zLovnh6YjUlLuuu9OGYshtCFt+Q4D5mWZVMwzjQ30iD
         kZgYpm11raGEUDegk0Be42OEkyiZnq3KbQTTVIApaN+JyIkHefcUweFGiLX8IfNmw7
         leFqzFP9Q/dcxXJfYwSvkq3T7Y7eTvYEKGiU6t1cM3Og6yHsohOxn0rFYNRfIgT5zX
         2+F56R0biKBD4mXU1g+NoKH83puQhQNF+MUP8IoNVU5UQUtX/ZN1Ra8zqlMmbGwQWd
         UHz8m2UtlDYrm+fnIPCGaklSbR91AmilQjiPeNLoWJCQtZUn94Qv9//ftJRzeJrEsB
         59ZHJ+YvSXLYA==
Date:   Tue, 10 Oct 2023 17:53:22 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        Liam.Howlett@oracle.com, netdev@vger.kernel.org,
        oliver.sang@intel.com
Subject: Re: [PATCH v1] Bug fix for issue found by kernel test robot
Message-ID: <20231010175322.0efb8a87@kernel.org>
In-Reply-To: <20231010213549.3662003-1-anjali.k.kulkarni@oracle.com>
References: <20231010213549.3662003-1-anjali.k.kulkarni@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the fix! Let's start with some basic process feedback :)

On Tue, 10 Oct 2023 14:35:49 -0700 Anjali Kulkarni wrote:
> Subject: [PATCH v1] Bug fix for issue found by kernel test robot

Subject needs to describe the issue (e.g. fix null-deref due to $xyz)

> cn_netlink_send_mult() should be called with filter & filter_data only
> for EXIT case. For all other events, filter & filter_data should be
> NULL.

We need (1) a Fixes tag pointing to the commit which added the bug
(2) appropriate Reported-by tag (see the syzbot report)

> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
-- 
pw-bot: cr
