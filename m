Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4097B8085EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378629AbjLGKxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjLGKxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:53:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C82110D0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:53:10 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2E43E1F8C4;
        Thu,  7 Dec 2023 10:53:08 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A786139E3;
        Thu,  7 Dec 2023 10:53:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id aVn4BBSkcWXqXwAAn2gu4w
        (envelope-from <dwagner@suse.de>); Thu, 07 Dec 2023 10:53:08 +0000
Date:   Thu, 7 Dec 2023 11:53:07 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 3/4] nvme: move ns id info to struct nvme_ns_head
Message-ID: <xpbwa63z7w6fa7mykmhhd56vdm3746y2x7vvtp5xj2st5aupvz@4rrj7gxzu66c>
References: <20231206081244.32733-1-dwagner@suse.de>
 <20231206081244.32733-4-dwagner@suse.de>
 <20231206085436.GB24484@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206085436.GB24484@lst.de>
X-Spamd-Bar: ++++++++++++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dwagner@suse.de) smtp.mailfrom=dwagner@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [18.89 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         MIME_GOOD(-0.10)[text/plain];
         MID_RHS_NOT_FQDN(0.50)[];
         BAYES_SPAM(5.10)[100.00%];
         R_SPF_SOFTFAIL(4.60)[~all:c];
         RCPT_COUNT_FIVE(0.00)[6];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         NEURAL_SPAM_LONG(3.50)[1.000];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 18.89
X-Rspamd-Queue-Id: 2E43E1F8C4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 09:54:36AM +0100, Christoph Hellwig wrote:
> On Wed, Dec 06, 2023 at 09:12:43AM +0100, Daniel Wagner wrote:
> > Move the namesapce info to struct nvme_ns_head, because it's the same
> > for all associated namespaces.
> > 
> > The head pointer is accessible from the ns pointer so we could just
> > update all places with ns->x to ns->head->x. While this is okay for the
> > slow path,
> 
> Do you have any data to show that it matters?  All the I/O command
> setup functions already access the ns_head for ->ns_id, so looking
> at more fields can't really make any difference.

I've splitted the patch so that the first patch just moves the variables
around and changes ns->x to ns->head->x ('patched'). Then I changed the
layout of nvme_ns_head, so that all variables used in nvme_setup_rw()
are in one cacheline ('cache line optimized') and the last change is
passing the nvme_ns_head pointer around ('use nvme_ns_head directly')

I assume that nvme_setup_rw is the function which is used most and thus
I've tried to benchmark nvme_setup_rw with issuing 4k reads. I am sure
my benchmark setup is not perfect but well that's what I have.

Anyway, the results are pointing towards that moving the variables to
nvme_ns_head has a slight performance impact but that can be more than
mitigated by optimizing the cacheline access. The change to use
nvme_ns_head directly seems to eat up all the cacheline optimization
gains again.

'patched' layout:

struct nvme_ns_head {
	struct list_head           list;                 /*     0    16 */
	struct srcu_struct         srcu;                 /*    16    72 */
	/* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
	struct nvme_subsystem *    subsys;               /*    88     8 */
	unsigned int               ns_id;                /*    96     4 */
	struct nvme_ns_ids         ids;                  /*   100    41 */

	/* XXX 3 bytes hole, try to pack */

	/* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
	struct list_head           entry;                /*   144    16 */
	struct kref                ref;                  /*   160     4 */
	bool                       shared;               /*   164     1 */

	/* XXX 3 bytes hole, try to pack */

	int                        instance;             /*   168     4 */

	/* XXX 4 bytes hole, try to pack */

	struct nvme_effects_log *  effects;              /*   176     8 */
	int                        lba_shift;            /*   184     4 */
	u16                        ms;                   /*   188     2 */
	u16                        pi_size;              /*   190     2 */
	/* --- cacheline 3 boundary (192 bytes) --- */
	u16                        sgs;                  /*   192     2 */

	/* XXX 2 bytes hole, try to pack */

	u32                        sws;                  /*   196     4 */
	u64                        nuse;                 /*   200     8 */
	u8                         pi_type;              /*   208     1 */
	u8                         guard_type;           /*   209     1 */

	/* XXX 6 bytes hole, try to pack */

	u64                        zsze;                 /*   216     8 */
	unsigned long              features;             /*   224     8 */
	struct ratelimit_state     rs_nuse;              /*   232   104 */
	/* --- cacheline 5 boundary (320 bytes) was 16 bytes ago --- */

[...]
}


'cacheline optimized' layout:

struct nvme_ns_head {
	struct list_head           list;                 /*     0    16 */
	struct srcu_struct         srcu;                 /*    16    72 */
	/* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
	struct nvme_subsystem *    subsys;               /*    88     8 */
	struct nvme_ns_ids         ids;                  /*    96    41 */

	/* XXX 7 bytes hole, try to pack */

	/* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
	struct list_head           entry;                /*   144    16 */
	struct kref                ref;                  /*   160     4 */
	bool                       shared;               /*   164     1 */

	/* XXX 3 bytes hole, try to pack */

	int                        instance;             /*   168     4 */

	/* XXX 4 bytes hole, try to pack */

	struct nvme_effects_log *  effects;              /*   176     8 */
	u64                        nuse;                 /*   184     8 */
	/* --- cacheline 3 boundary (192 bytes) --- */
	unsigned int               ns_id;                /*   192     4 */
	int                        lba_shift;            /*   196     4 */
	u16                        ms;                   /*   200     2 */
	u16                        pi_size;              /*   202     2 */
	u8                         pi_type;              /*   204     1 */
	u8                         guard_type;           /*   205     1 */
	u16                        sgs;                  /*   206     2 */
	u32                        sws;                  /*   208     4 */
[...]
}

fio test job:
  [global]
  name=nvme-read
  time_based
  ramp_time=30
  runtime=120
  readwrite=read
  bs=4k
  ioengine=io_uring
  direct=1
  numjobs=4
  iodepth=64
  group_reporting=1[nvme0]
  new_group
  filename=/dev/nvme0n1
  cpus_allowed=1-4
  cpus_allowed_policy=split

  [nvme0]
  new_group
  filename=/dev/nvme0n1

bandwidth
      'baseline'  'patched'  'cache line optimized' 'use nvme_ns_head directly'
      1608        1632       1613                   1618
      1608        1610       1634                   1618
      1623        1639       1642                   1646
      1638        1610       1640                   1619
      1637        1611       1642                   1620
avg   1622.8      1620.4     1634.2                 1624.2
stdev 14.75       14.01      12.29                  12.21

ios
      'baseline'  'patched'  'cache line optimized' 'use nvme_ns_head directly'
      65626946    66735998   66268893               66458877
      65641469    66041634   66888910               66384526
      66012335    66904002   67132768               67329550
      66589757    66013222   67132053               66491121
      66569213    66033040   67132075               66474708
avg   66087944    66345579.2 66910939.8             66627756.4
stdev 474608.24   437260.67  374068.50              394426.34
