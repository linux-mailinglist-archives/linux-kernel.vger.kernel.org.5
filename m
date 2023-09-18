Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037827A542D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjIRUc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjIRUc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:32:26 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233B3123
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:32:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695069134; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Bud8Z6al1N84VIdFD5Ib5zo4+PM661rhLFAj+W+wbdugubh6AZ1s5h46BWl6+1vJTsZyGQM0kLjEdg9J0Ad7wowdZvaRc1fNlQbA8iG+atvLqgMzeUPWc8EIFon9NBoOO8qKEGVQxPAfFTK/BfNidewRon2Zudql+WplxZFfw28=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1695069134; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=84KZ7QT3hsyHL8DA1HX0H4FHyIqKjiKh+sqO7hcuyNM=; 
        b=G4x3dyW1MSz/PKY3Uv0a1AfaM930CHYy3F0CUTvX1sFG2VsA1WOCEoUhekFm53ZvDpuL+tBlDyg7d25ELztWH7xca3N28g3KcRlhckMsB8FiEWy2DDoFn4JpD9GlKgKryt0cK2lMcQ037LBf/gB1QJ0t/FIPofng3uSixC0iYRg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=marliere.net;
        spf=pass  smtp.mailfrom=ricardo@marliere.net;
        dmarc=pass header.from=<ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1695069134;
        s=zmail; d=marliere.net; i=ricardo@marliere.net;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=84KZ7QT3hsyHL8DA1HX0H4FHyIqKjiKh+sqO7hcuyNM=;
        b=HKqMSe2CUEQ3YrT1X6SPH95QPH4+ruiop+7VmI+ZvC/gFbhXYHxaJPpc8U7QU8Bz
        UVLVbfHkQkmLhJHcPdSnVmZnKWEhlHvvTV/g4tLRWwoM14h2CL19JwHRU3sFz7EfAzs
        xRbJBzFka97dzOuksK/cxy6u1M5pygU8L6+zW7wo=
Received: from localhost (177.104.93.54 [177.104.93.54]) by mx.zohomail.com
        with SMTPS id 1695069133184732.9716988015931; Mon, 18 Sep 2023 13:32:13 -0700 (PDT)
Date:   Mon, 18 Sep 2023 17:32:23 -0300
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     syzbot <syzbot+410a8e33c6a740b40d51@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] general protection fault in hci_register_dev
Message-ID: <crdz3rljawhzb24yict4xxroodjtfhw22q4b3moh2uhmqgjq2h@gja4wnqjiubu>
References: <0000000000002683d00604c6bafe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002683d00604c6bafe@google.com>
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git fd6f7ad2fd4d53fa14f4fd190f9b05d043973892
