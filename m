Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3837B1BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjI1MR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjI1MR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:17:56 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09DD139
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695903439; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=l61lbAV5WIA/lUystlH8zmH7Uzi3IU0ZnNEHOv6GNSfZpWfJtU5/YuRsHSskWMZn5YD00JJSYwMzsg78lPMHFceN0hAptSPNbran57TtzfazgPjMhIlWEkfVFTOcY2RTGyiQ5LyPs+OqzBsw04DhY7OOyrdUy+LD5AOHsP3ep+8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1695903439; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=iZy+jCOWB/CWrGEZQBaHCz0SuWNHhtFFYK98f71cH0o=; 
        b=VojAC7XxZhXHaKgSNBJV9FJ+bvvySuA+Qr7U+8NNyuIAs/P12vlxfK6x8aPYEY5Tn55uQ6sx8bFZPMuNAfEefWDjLsLLdYipPxyN3BxcYzrSd/CEQcenL5+F5wQ2l+Pye9owbXeX4j1Al4rI+g/7nBjW9UMiNzYQ9X9n5Us3UZM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=marliere.net;
        spf=pass  smtp.mailfrom=ricardo@marliere.net;
        dmarc=pass header.from=<ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1695903439;
        s=zmail; d=marliere.net; i=ricardo@marliere.net;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=iZy+jCOWB/CWrGEZQBaHCz0SuWNHhtFFYK98f71cH0o=;
        b=cApQ+RoJq17IQHWxjFrDS2eutYSpM7TADoAsBhacHZDSJnWWvi4ChmwBXzGnU+ZS
        huw4a73IQVD/SuuSrIaqay3258p1nQPEfA7XJH1UbmLmKHkoPK1VIdP6CZ2HOm22h2V
        cNanxAIPSd85+SHGUUVhyeOeAGlrLfowQ8usoC48=
Received: from localhost (177.104.93.54 [177.104.93.54]) by mx.zohomail.com
        with SMTPS id 1695903436330272.35798225324527; Thu, 28 Sep 2023 05:17:16 -0700 (PDT)
Date:   Thu, 28 Sep 2023 09:17:11 -0300
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+621409285c4156a009b3@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [pvrusb2?] KASAN: slab-use-after-free Read in
 pvr2_context_set_notify
Message-ID: <2qrcgpk54bcmtpwgzc7if5fb2u24d3wbgfwwzxb2fcjnwoxjtp@6owflexhzeri>
References: <000000000000a71ad80606586122@google.com>
 <20230928112020.1277-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928112020.1277-1-hdanton@sina.com>
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

Good one, but make sure to test against Greg usb-testing tree!

Thanks,
-	Ricardo
