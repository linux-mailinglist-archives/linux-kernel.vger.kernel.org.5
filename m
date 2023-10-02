Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D522E7B52DA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbjJBMVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbjJBMVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:21:46 -0400
Received: from mx.treblig.org (mx.treblig.org [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBFBDA
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=F9eLwgO+MkVIbXgjb3UHbTj6w2g/gdCYsvQUqOspZFo=; b=BSfFWDQ4PQPCxGYsGJnFNUzeok
        aeaAaYrnZz/xsH/XEMEksDy70JLL6u5H4eKtvzPjPrQOR41Jzl8owTGhCF4BC4/6EKkcF0d3oP4if
        760+TYSt+OJWpVInI4E6P3bcuTmrk+vN6pZ9FTlcN6KL8x/UKkD4i3mi3WeyhyXQn/jd6KD+FGWON
        nVrZ8k229I99CCEHUrTyKDUlsv3Azxo8cfYDwW26YE+EEipNX47SLL/io/7FWYSdGgzvVpHGMFzUR
        PI+Qqi7fl0AF2eRLzsoA5cz2R3CAYYHmJsrqjc/K0/AmHtqv4cN9I01UK+mdSQZzqHLjJtGxZ3VR4
        10H9cDfA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
        (envelope-from <dg@treblig.org>)
        id 1qnHvZ-002M2W-2e;
        Mon, 02 Oct 2023 12:21:33 +0000
Date:   Mon, 2 Oct 2023 12:21:33 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu, sam@ravnborg.org,
        benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH v4] powerpc: Use shared font data
Message-ID: <ZRq1zUTmnydbEk2S@gallifrey>
References: <20230825142754.1487900-1-linux@treblig.org>
 <ZRgfVfaIkEWsL8Ha@gallifrey>
 <87a5t2sfxx.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87a5t2sfxx.fsf@mail.lhotse>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-12-amd64 (x86_64)
X-Uptime: 12:21:14 up 16 days, 15:19,  2 users,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Ellerman (mpe@ellerman.id.au) wrote:
> "Dr. David Alan Gilbert" <linux@treblig.org> writes:
> > * linux@treblig.org (linux@treblig.org) wrote:
> >> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >> 
> >> PowerPC has a 'btext' font used for the console which is almost identical
> >> to the shared font_sun8x16, so use it rather than duplicating the data.
> >
> > Hi Michael,
> >   Are you going to pick this up for 6.7?
> 
> Yes I will.

Thanks!

Dave

> cheers
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
