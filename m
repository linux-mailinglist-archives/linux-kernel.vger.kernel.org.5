Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063C37E5293
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbjKHJVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbjKHJVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:21:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8155D10A;
        Wed,  8 Nov 2023 01:21:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51014C433C8;
        Wed,  8 Nov 2023 09:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699435262;
        bh=9f1HWkCwCFtzk3fX889cU2VmJzksISA21iZ6B4BDtY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ffx2uh2ybtQm2VWN6sUqgEmp+f4T8KlTqy+vKM/yR25g1fiiGYU3n3SKANcJnNIT/
         B0RG6ZT8lLSZRnZPNWXnE++9DaEpN+rEwCSp7hISUK6YnM2N5Slcw/Em8wuJy+vwg7
         GNgY1qSTGhAtN6SV+rjEI3tInTNktZUkK03tOC1nF/BneKjW51QR4nZoK9UZeB+q10
         KPO4hPWzCK9ztXaXC3ztWrxVFv2qJzmRvu1/aoBvdddCiyVy7f1Xec/yVIQyZXYbFq
         fiUgEV4hsah02Yb+4IkFdi6M6Ua+PIYyNUthYTNGjorHQaLHO36sZ+GPFY1/B4aYmk
         K1Mbtz6RR4leg==
Date:   Wed, 8 Nov 2023 10:20:56 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     amir73il@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Pass AT_GETATTR_NOSEC flag to getattr interface
 function
Message-ID: <20231108-knieprobleme-aufhielt-562b5bbafb79@brauner>
References: <20231002125733.1251467-1-stefanb@linux.vnet.ibm.com>
 <20231010-erhaben-kurznachrichten-d91432c937ee@brauner>
 <e6b66098-77d6-46e9-b013-986ad86ba26b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6b66098-77d6-46e9-b013-986ad86ba26b@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Did something happen to this patch? I do not see it in your branch nor the
> linux-next one nor Linus's tree.

Sorry, my bad. I'll send that out as a fixes pr soon.
