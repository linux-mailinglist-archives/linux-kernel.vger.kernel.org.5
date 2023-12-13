Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7377811C59
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjLMS1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjLMS1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:27:11 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326AEA7;
        Wed, 13 Dec 2023 10:27:18 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:50630)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1rDTwx-000ZKP-6d; Wed, 13 Dec 2023 11:27:15 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:38540 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1rDTww-007q8r-4s; Wed, 13 Dec 2023 11:27:14 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Maria Yu <quic_aiquny@quicinc.com>, kernel@quicinc.com,
        quic_pkondeti@quicinc.com, keescook@chromium.or,
        viro@zeniv.linux.org.uk, brauner@kernel.org, oleg@redhat.com,
        dhowells@redhat.com, jarkko@kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20231213101745.4526-1-quic_aiquny@quicinc.com>
        <ZXnaNSrtaWbS2ivU@casper.infradead.org>
Date:   Wed, 13 Dec 2023 12:27:05 -0600
In-Reply-To: <ZXnaNSrtaWbS2ivU@casper.infradead.org> (Matthew Wilcox's message
        of "Wed, 13 Dec 2023 16:22:13 +0000")
Message-ID: <87o7eu7ybq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rDTww-007q8r-4s;;;mid=<87o7eu7ybq.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/VU39+2YW8c791zJoSkh67aCTXIOvQAFw=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Matthew Wilcox <willy@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 465 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (2.4%), b_tie_ro: 10 (2.1%), parse: 0.85
        (0.2%), extract_message_metadata: 11 (2.3%), get_uri_detail_list: 0.81
        (0.2%), tests_pri_-2000: 11 (2.4%), tests_pri_-1000: 2.5 (0.5%),
        tests_pri_-950: 1.16 (0.3%), tests_pri_-900: 1.01 (0.2%),
        tests_pri_-90: 193 (41.5%), check_bayes: 189 (40.7%), b_tokenize: 6
        (1.3%), b_tok_get_all: 63 (13.5%), b_comp_prob: 3.3 (0.7%),
        b_tok_touch_all: 114 (24.5%), b_finish: 0.94 (0.2%), tests_pri_0: 221
        (47.5%), check_dkim_signature: 0.53 (0.1%), check_dkim_adsp: 2.6
        (0.6%), poll_dns_idle: 0.46 (0.1%), tests_pri_10: 2.0 (0.4%),
        tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for
 tasklist_lock
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Wed, Dec 13, 2023 at 06:17:45PM +0800, Maria Yu wrote:
>> +static inline void write_lock_tasklist_lock(void)
>> +{
>> +	while (1) {
>> +		local_irq_disable();
>> +		if (write_trylock(&tasklist_lock))
>> +			break;
>> +		local_irq_enable();
>> +		cpu_relax();
>
> This is a bad implementation though.  You don't set the _QW_WAITING flag
> so readers don't know that there's a pending writer.  Also, I've seen
> cpu_relax() pessimise CPU behaviour; putting it into a low-power mode
> that takes a while to wake up from.
>
> I think the right way to fix this is to pass a boolean flag to
> queued_write_lock_slowpath() to let it know whether it can re-enable
> interrupts while checking whether _QW_WAITING is set.

Yes.  It seems to make sense to distinguish between write_lock_irq and
write_lock_irqsave and fix this for all of write_lock_irq.

Either that or someone can put in the work to start making the
tasklist_lock go away.

Eric

