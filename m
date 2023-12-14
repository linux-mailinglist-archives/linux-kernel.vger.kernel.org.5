Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3B1812D60
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443767AbjLNKuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443786AbjLNKup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:50:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A131123
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:50:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C00C433C8;
        Thu, 14 Dec 2023 10:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702551052;
        bh=B3Uzhdrf3xm+8hmipnGveC7xOj8Hsd8r5ig/mSxdums=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cjW7wdE0wJKpOB85/uTrRUZDMYAzvL5sJeBifjJFoP9i7NGE5Oi7a+4FO7v2ai+l4
         nVbRAw9ZKZd5dfjc2HHHRBrOLhKc+W2RUxZ4nkoftoeW/uaTBN4SDGKYEV1zvjHXBL
         vdM9RbsYQqhNyz+LHodwpS4E7AsD7curbtBCxaF6IrSytdaPiViHD+B+tuyNslANj6
         TMEXUovKVZxIZF0dnS+NXydDH/xos7XtdhqYb+NOMcJcVui3XOw9SHU7I0wbxG1AQx
         Nom7GRyNXKt/X6L98kcxe2/PAfWM98PoFAJW4gkP3+9ecSqwycW81aSFJb0dYjmvS5
         3/1ugywDFRH4Q==
Date:   Thu, 14 Dec 2023 11:50:45 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Tony Lu <tonylu@linux.alibaba.com>,
        Ahelenia Ziemia'nska <nabijaczleweli@nabijaczleweli.xyz>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RESEND 06/11] net/smc: smc_splice_read: always request
 MSG_DONTWAIT
Message-ID: <20231214-glimmen-abspielen-12b68e7cb3a7@brauner>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
 <145da5ab094bcc7d3331385e8813074922c2a13c6.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
 <ZXkNf9vvtzR7oqoE@TONYMAC-ALIBABA.local>
 <20231213162854.4acfbd9f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231213162854.4acfbd9f@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Let's figure that out before we get another repost.

I'm just waiting for Jens to review it as he had comments on this
before.
