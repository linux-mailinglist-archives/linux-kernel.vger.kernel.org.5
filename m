Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D45755102
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 21:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGPTbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 15:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjGPTbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:31:25 -0400
Received: from abi149hd126.arn1.oracleemaildelivery.com (abi149hd126.arn1.oracleemaildelivery.com [129.149.84.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AEC1985
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 12:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=1X2J9Yn20F/BEmGq9y/x0FBrrb96P1AoI6JRoNuLx48=;
 b=hhYQHeWeU3tWLwkcoWUkS7C8RqLLTN6gdAl5d6RHOsD6mFDYNN8KTBTyAWR1eU5dwokmiavsFfW3
   vaVh+c1pvIKb0/s449uLlfHT75ASed294nTe6MVD72MtEHaIUizStnmLW2MMRLDGQaOOYbTZRfdx
   4TG6s9sGdM1hM7dXn/dvWh0YijIczoFWwn+0CR0uRS5EsoUOBGipTodMsYTCzc4OXH1UeQSSspC/
   gL57Z5mEtHYUIjERn1ZS7VYl6DQUgwMoM94eezODEqvOMNDYxRjbPt/BK+qPiZNXd2ZCL8D/MCJz
   tGab/fg6WDylUfGRsWgR1YD0Ns8z2bMUR9lz0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=1X2J9Yn20F/BEmGq9y/x0FBrrb96P1AoI6JRoNuLx48=;
 b=MTAHRUN67jyzpHcQ1EHcYebCrL+Zrea6rPHGTQrZrZydIfK3QTKJUkEdwF/jYpwcsSLEzv4ndYAy
   oNGWRfebaxV6iVN23mJ2mWABO6rDERU7zT81tw7cEHeVILT0oqndir+WvHhjf25x9rzdqd0FYMe0
   oR/PUQlQ7NRn6jcXvDR6MuPaC8PYjMHGsU79z+go/9wHjSqf0ku2vqKsDXTQXG9A8B45KrinkjVt
   aTmxrs0AnN21QifSEZfaH58rgBxE7PbDE6Ycp8ifPWiF5r7oCFuAliujU1ivrOT2xH8XWwV6CK9/
   BOCgtNbV7xdiyA/SnSWn6kQIB2wROYijXjCZLg==
Received: by omta-ad1-fd3-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230629 64bit (built Jun 29
 2023))
 with ESMTPS id <0RXW00740M78V730@omta-ad1-fd3-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-kernel@vger.kernel.org; Sun, 16 Jul 2023 19:30:44 +0000 (GMT)
Message-id: <0206e2ce-ff33-6017-15ab-cc89f1eb7485@augustwikerfors.se>
Date:   Sun, 16 Jul 2023 21:30:41 +0200
MIME-version: 1.0
From:   August Wikerfors <git@augustwikerfors.se>
Subject: Re: [PATCH] nvme-pci: Add quirk for Samsung PM9B1 256G and 512G SSD
To:     Nils Kruse <nilskruse97@gmail.com>
Cc:     stable@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <b99a5149-c3d6-2a9b-1298-576a1b4b22c1@gmail.com>
Content-language: en-US
In-reply-to: <b99a5149-c3d6-2a9b-1298-576a1b4b22c1@gmail.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAEqHmCrKsOnH195OEdwrfg9FTxZzACbRkpk03nDz2o7ewDk7A9Vjq6UenQjGOdN
 kAaYT+day+D9LnofH23ymNDd3QZ5lX8jc6rFDq0DQ21fDeE6KBc3uN4DOdizh1/R
 pKQb2zwE3EALmxo4SVfpkFgd7ga5c7I8QUBTBL3Qvclu4ONbzGQ3W3SPG8bQ/80O
 g+wNwYXy1YU/4qmVxw5DrPBQz2af/eNK3QVu1uAAQAyypUKroZiVOqm3ae92UOdL
 Vej7FeXeeQq2dZC+Bx4njGjOmg8A67VKDhC4tpIMvNAebRPfre6lKZTdo/iACA0V
 i/WdZzXW/jgqHRB/0hLW6W7XrwLIWYF+n2BkNHvLiuxNXM/a3Tfv6I8GHBiGEmNe
 E/ch80gPDqso9Yi6hBrZ8QGijs2fc/8jnEit7F6P/k/FyG6IBrJeacxoQc/E8LwT UcuPNA==
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_RED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-11 13:41, Nils Kruse wrote:
> Add a quirk for Samsung PM9B1 256G and 512G that reports duplicate ids 
> for disk.

Is this the same issue with suspend as [1], [2] and [3] or is it a
different case?

[1] https://lore.kernel.org/all/20221116171727.4083-1-git@augustwikerfors.se/t/
[2] https://github.com/tomsom/yoga-linux/issues/9
[3] https://lore.kernel.org/all/d0ce0f3b-9407-9207-73a4-3536f0948653@augustwikerfors.se/
