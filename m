Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1C17B55A8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbjJBOgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237807AbjJBOg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:36:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FCCAB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:36:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BB5C433C9;
        Mon,  2 Oct 2023 14:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696257384;
        bh=ViIMzQtiwxZ76FMvkMoS/FCCi7hvSNTyNa/YQnxasRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H1nf5x0ge5ivb7BeTnH+lPAbQpQ3mdFVSb40BSsIQhUHRQJC8/bjphwKQAtNiV5bF
         QGX4NiIkaYJc3zZubv0mUSMJMtHYVkDA7lJV3wq0/qjF8J3o+gP+jv5NM1Fb+sdh4Q
         QMMd0NgqOInVs4jRZU8BP9TGKb9tkOmZmJP3+CAzYDBRzAmmHqqQ4CDom2QjXeTesa
         OUmeSEY7xqKH6pJCkq8gSHhxo9nYHho2b2Xj4ou00xE5+aGsB9vjuDEWIUkDmgUDeo
         e9M4EIQcP2YzHqWSQalrGYLYACbrFt+H9+81Ez4g3r1QeLvF+IoKmPp0YWahnG/Jrl
         i24Aob9JNK4hw==
Date:   Mon, 2 Oct 2023 15:36:19 +0100
From:   Lee Jones <lee@kernel.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     chengzhihao1 <chengzhihao1@huawei.com>, Yu Hao <yhao016@ucr.edu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG: divide error in ubi_attach_mtd_dev
Message-ID: <20231002143619.GC8453@google.com>
References: <CA+UBctD_w=75wChmePZHp7KsBSNPWYGDBtzHPRPPtaFoqhGvXA@mail.gmail.com>
 <412779912.228444.1682023015809.JavaMail.zimbra@nod.at>
 <ed510d18-47f1-7f46-03dd-84e043cab6d9@huawei.com>
 <1366603418.245114.1682236940160.JavaMail.zimbra@nod.at>
 <951e4cf7-a0ea-b3ec-931d-e6a394ddc2ab@huawei.com>
 <20231002101117.GA175828@google.com>
 <43988304.25483.1696242486225.JavaMail.zimbra@nod.at>
 <20231002140437.GA8453@google.com>
 <918629851.25781.1696256100853.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <918629851.25781.1696256100853.JavaMail.zimbra@nod.at>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2023, Richard Weinberger wrote:

> ----- Ursprüngliche Mail -----
> > Von: "Lee Jones" <lee@kernel.org>
> > Excellent, thanks.
> > 
> > I'd like to track it.  What's the subject please?
> 
> "ubi: Refuse attaching if mtd's erasesize is 0"

That's great, thank you Richard.

-- 
Lee Jones [李琼斯]
