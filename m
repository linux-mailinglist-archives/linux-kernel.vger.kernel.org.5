Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504287BC6BB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 12:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343803AbjJGKWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 06:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343749AbjJGKWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:22:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D7B92;
        Sat,  7 Oct 2023 03:22:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68567C433C7;
        Sat,  7 Oct 2023 10:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696674165;
        bh=CvtSrGgl9A7qKAFVHhed6wrTgPTh2PEfSXdSNaaXH/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ScaSgdix0I61SOZRQ3IxaMZKN6pATDiwwmNQQClu/hKMB3nQiW+MpI/ax1fC9cSMW
         UuYv1ZZo0g7s9g7NuZdaZPXLuq8Qcelccfb6sXCyckYNh0fzd/WjaWnAi9KqZ+G4wC
         nGvS3b0BT4uBYpZ0ir+RQ1xRx2eMOIcHFVX6NOvY=
Date:   Sat, 7 Oct 2023 12:22:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Wensheng <zhangwensheng@huaweicloud.com>,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        Hillf Danton <hdanton@sina.com>, Yu Kuai <yukuai3@huawei.com>,
        Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH] block: fix use-after-free of q->q_usage_counter
Message-ID: <2023100735-uranium-treble-2d06@gregkh>
References: <20230921182012.3965572-1-saranyamohan@google.com>
 <2023092258-clothing-passerby-e0f2@gregkh>
 <CAP9s-SrHMFD6Q8t9Htk8W5OrQTAoe2D51ZRf-Zap4O_3E485LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP9s-SrHMFD6Q8t9Htk8W5OrQTAoe2D51ZRf-Zap4O_3E485LA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 11:21:10AM -0700, Saranya Muruganandam wrote:
> Apologies for leaving out the stable release info.
> This is for both 5.10 and patch applies cleanly for 5.15.
> 
> I just sent out a (different) modified patch for 6.1 LTS.

All now queued up, thanks.

greg k-h
