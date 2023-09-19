Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA65C7A69B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjISRjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjISRjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:39:22 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C64FAD;
        Tue, 19 Sep 2023 10:39:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695145152; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=QdHbBLLn+tiPHsQULmPbOn6OBooc6H5vxiZWz4W+fqWZbICjaF7DpzJ3/fwYKcTpg/WvJGOKQEcx84b4nWHSbdu1Ep2gM386gMibr6oGLVOUjntgHWffvD/DY22aiHv5kulMIjrlgrIQWI2G65/41XwKrcFc32uQESDDobNSmMk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1695145152; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=0IAP0s+RT7GZFRPLNdV3G0ElvDn5rBd3toR6u/oZ7UE=; 
        b=M9/PhhM9I7hqsewz3/VPoYPdvlGQ62QHkA/jZMBHm4d2ProZzQz47XwB93NQFGvxtnaFUvaQzyQabelHtz7TLZStDuuIp+PGrdVy6o+ha1yvZOFX9wcRxePJUUjKCSbA8O4r70PP43bXVlmbH0jWcFbVDuHb8F63f0Bkbz0rLtY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=marliere.net;
        spf=pass  smtp.mailfrom=ricardo@marliere.net;
        dmarc=pass header.from=<ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1695145152;
        s=zmail; d=marliere.net; i=ricardo@marliere.net;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=0IAP0s+RT7GZFRPLNdV3G0ElvDn5rBd3toR6u/oZ7UE=;
        b=F9+wr7Fc3a7fOb1iB0k4UxWASWuxg4D6d8suw5fFRNKcoRFt58ufFSOjDeGPaifO
        qkMjVzB4r0AV09tIYz5e/d2D8xrUPDKL/rFL5dPjT0vMYqfpieJWPwjaimvsKBDgyqH
        fofwXfdkWQ/LkSXCybkyjnq2lVspOjv66aliatNI=
Received: from localhost (177.104.93.54 [177.104.93.54]) by mx.zohomail.com
        with SMTPS id 1695145150671314.9472263153632; Tue, 19 Sep 2023 10:39:10 -0700 (PDT)
Date:   Tue, 19 Sep 2023 14:39:20 -0300
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     syzbot <syzbot+59875ffef5cb9c9b29e9@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org, sean@mess.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [media?] [usb?] KASAN: slab-out-of-bounds Read in
 imon_probe
Message-ID: <albu6mqbrom746yngcfgtuhn6ydpf4ewapqj6wk6etlkw7qda4@tzlqwq6u5s54>
References: <000000000000a838aa0603cc74d6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a838aa0603cc74d6@google.com>
X-ZohoMailClient: External
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git next-20230919
