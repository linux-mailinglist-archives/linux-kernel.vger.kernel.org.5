Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5309A76C942
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjHBJRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjHBJQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:16:58 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83503AAB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:16:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so60656235e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 02:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1690967782; x=1691572582;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=00Deh1KqaGOo8Q3/vfjn8WmFooRbDdLKDL8pC9jYyCQ=;
        b=E+QsCpCYQMLwK8CsU/EqmN3REjOC6vzcjlyRkilPUfeh4aJ8RFwdWz45RCbFas/Whp
         qjADTLbA/3xZEdc8/Hgr6h29699Pq3Pj3oB2l6Aeet2Mc+B2T/AaGULF78sJ6Vdwyups
         /EpywYPIBVjcCKCKOYlTcqgdlAqe2/d24yC0i3hCGHNfsFo5mDBjMJ2ccOJEoO2E8Ydw
         ljwYh818x9h3w1QyL0A1uRj8jepEKcPwUEExO3G0tl7rVBxFof2QSVnj6EacLD1giYi3
         HneHp97da3NxUERErsg+NHR2L1C/yg0dUxlbBPH8e4RgR0LdZzcoQAJkcuSeLdCB5lJe
         KQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690967782; x=1691572582;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00Deh1KqaGOo8Q3/vfjn8WmFooRbDdLKDL8pC9jYyCQ=;
        b=PQ5Fizf93b5AblRjjU4IA38ksWcI1kd7Xvadkdd3IRWeMerEAON+z/mXZmj03cBPNA
         mm4OBZh/wPJVYXJeriLoHG314eLpH3CwiWcIA6W/I1Bc1W1f/+RnMDUBbjp/jFK9C6cK
         AmsIrcNpSEp3f6bxTsyUs1s+JgeioVgUAkVjGUC88fiUyh5chZctwWXw0e73emgGIP+N
         xpRwKgCqvjzDrr/UcqiVcsewk9Oj/tIXxzHev+OvKxpmxgkbZh9iGllHyN7Vv7sa5rHk
         yjFTmFGeQVOAfgPSnyuozusSjZBYAP2wG4X6mvrwBIOqLfZVhH8NRugA+b/nkM2/d6dN
         WzMg==
X-Gm-Message-State: ABy/qLaF7HdcqnguuRaNS7b3UKjDlCCZwwxWw5DSuYFlI3qLnMv07i3g
        rqDIW/ITtHsjOh6SY6GOaBxIzg==
X-Google-Smtp-Source: APBJJlExcQ/QaLqfDVVqQGS/9bfvXdFHbOfePluPR9zhy5Z3WpuSireQcXkq9bTVmXceflGlsONNSQ==
X-Received: by 2002:a05:600c:2155:b0:3f7:f584:579b with SMTP id v21-20020a05600c215500b003f7f584579bmr4180925wml.9.1690967781569;
        Wed, 02 Aug 2023 02:16:21 -0700 (PDT)
Received: from localhost ([147.161.155.73])
        by smtp.gmail.com with ESMTPSA id f2-20020a7bc8c2000000b003fe29f6b61bsm1119406wml.46.2023.08.02.02.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 02:16:21 -0700 (PDT)
References: <20230714072510.47770-1-nmi@metaspace.dk>
 <20230714072510.47770-3-nmi@metaspace.dk> <ZLfQjNK5j5lB68C/@x1-carbon>
 <87il9zot9c.fsf@metaspace.dk> <ZMkBbvb7EFyT/zGX@ovpn-8-18.pek2.redhat.com>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Matias =?utf-8?Q?Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v9 2/2] ublk: enable zoned storage support
Date:   Wed, 02 Aug 2023 11:09:56 +0200
In-reply-to: <ZMkBbvb7EFyT/zGX@ovpn-8-18.pek2.redhat.com>
Message-ID: <87a5v9pzx7.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ming Lei <ming.lei@redhat.com> writes:

> On Tue, Aug 01, 2023 at 02:11:56PM +0200, Andreas Hindborg (Samsung) wrote:
>> 
>> Niklas Cassel <Niklas.Cassel@wdc.com> writes:
>> 
>> > On Fri, Jul 14, 2023 at 09:25:10AM +0200, Andreas Hindborg wrote:
>> >> From: Andreas Hindborg <a.hindborg@samsung.com>
>> >
>> > Hello Andreas!
>> >
>> 
>> <snip>
>> 
>> >>  	/* for READ request, writing data in iod->addr to rq buffers */
>> >> @@ -1120,6 +1404,11 @@ static void ublk_commit_completion(struct ublk_device *ub,
>> >>  	/* find the io request and complete */
>> >>  	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
>> >>  
>> >> +	if (io->flags & UBLK_IO_FLAG_ZONE_APPEND) {
>> >
>> > Do we really need to introduce a completely new flag just for this?
>> >
>> > if (req_op(req) == REQ_OP_ZONE_APPEND)
>> >
>> > should work just as well, no?
>> 
>> Makes sense, thanks.
>
> The above one can be replaced with req_op().
>
> But extra cost is added when retrieving request for the check in
> __ublk_ch_uring_cmd().
>

How about this (diff to v9):

@@ -1709,7 +1702,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		goto out;
 
 	if (ublk_support_user_copy(ubq) &&
-	    !(io->flags & UBLK_IO_FLAG_ZONE_APPEND) && ub_cmd->addr) {
+	    _IOC_NR(cmd_op) != UBLK_IO_COMMIT_AND_FETCH_REQ && ub_cmd->addr) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1751,6 +1744,12 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
 
+		if (ublk_support_user_copy(ubq) &&
+		    req_op(req) != REQ_OP_ZONE_APPEND && ub_cmd->addr) {
+			ret = -EINVAL;
+			goto out;
+		}
+
 		if (!ublk_support_user_copy(ubq)) {
 			/*
 			 * COMMIT_AND_FETCH_REQ has to provide IO buffer if


BR Andreas
