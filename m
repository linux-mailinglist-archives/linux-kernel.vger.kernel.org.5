Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EF3777DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbjHJQPn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Aug 2023 12:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbjHJQPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:15:40 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA07D211B;
        Thu, 10 Aug 2023 09:15:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 76729622F562;
        Thu, 10 Aug 2023 18:15:37 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id smA3OYxeUDzS; Thu, 10 Aug 2023 18:15:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0F795622F56E;
        Thu, 10 Aug 2023 18:15:37 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5mrpLoPTvxi8; Thu, 10 Aug 2023 18:15:36 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D925E622F562;
        Thu, 10 Aug 2023 18:15:36 +0200 (CEST)
Date:   Thu, 10 Aug 2023 18:15:36 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Stephan Wurm <stephan.wurm@a-eberle.de>,
        stable <stable@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        James Bottomley <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Message-ID: <298860961.5257332.1691684136772.JavaMail.zimbra@nod.at>
In-Reply-To: <ZNUK8nWnUYB6B4Kg@infradead.org>
References: <20230810160019.16977-1-richard@nod.at> <20230810160019.16977-2-richard@nod.at> <ZNUK8nWnUYB6B4Kg@infradead.org>
Subject: Re: [PATCH 1/7] ubi: block: Refactor sg list processing for highmem
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: block: Refactor sg list processing for highmem
Thread-Index: 8dyYm2xXARBKErxuajcdul9nN/entQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Christoph Hellwig" <hch@infradead.org>
>> Refactor ubi_eba_read_leb_sg() to use kmap_atomic() for sg list
>> access.
>> Since kmap_atomic() disables preempt a bounce buffer is needed.
>> kmap_local_page() is not used to allow easy backporting of this patch
>> to older kernels.
>> 
>> The followup patches in this series will switch to kmap_sg()
>> and we can remove our own helper and the bounce buffer.
> 
> Please just use kmap_local and avoid the bounce buffering.

Patch 6 does this.

Thanks,
//richard
