Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1D179D438
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbjILPAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbjILPAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:00:32 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117DB115;
        Tue, 12 Sep 2023 08:00:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401da71b7faso67129095e9.2;
        Tue, 12 Sep 2023 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694530826; x=1695135626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NH5eOrQxa1sjHwnDCa9u5wvZcfuiYRsfn3SOuUZxYnI=;
        b=Q6ehP4Qpfs+dIl/2XitQmmVJO5cabxy0wmq0LfQEWxcG7tP0gBvbbPnS9ykRvrIqZJ
         IhhJUrck+XCncvPTWZ9upFOFrdLdpqRLLU0yIj29qBN6TaUAZ0Oh7pFbRQ5tOI+Z3Yt6
         tyFlZ2hSR9vdOmxeuV0miWa4YFAsK9z4bLGh808i7cZI5PI/9raN46uKzW3ol3HkaU83
         V5nulJBiFYATq5E9+YfabnHjTi142oueheDAl17QBRM8p4eSyrR21wXNULHx3mszHsh4
         QdlFjGdd2VWNSIp7micsrKMuMTYcbhuZxyRgAjHA7xjWGu9zav7HzscDvo1hHHrkFMwW
         sA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694530826; x=1695135626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NH5eOrQxa1sjHwnDCa9u5wvZcfuiYRsfn3SOuUZxYnI=;
        b=op+D+XHhPsnTOgSm8Y96Ceq8QdZcO/hVM1cx3GlZ51a7uMgPbGTy48UbBv4AxQZ1jC
         LIJiA4lXItpRqB17+rlz14TW84NHbDKkbveJdKCpggOMb7OQ/uCjHP7rVKWHTzAxt2tJ
         7e8/StGH1DIIxLYlHOFCg2w7022NPff76+6IAUtVwkRsqAfWjnzCvIPU7betrJNLDkOO
         cJH14NNgSUDI35CpWr/m9bO5f3yt3NujSHJlAcHE0ED0YiOWw3DFpghN83Qj1PLZifvE
         KksNqMVpj7hxCm6JZFBeMb2W4VttFLnaLjFrRpNf8KstKaR3v1pbRACrn8b1cA874+WF
         I62A==
X-Gm-Message-State: AOJu0YyLrv3clUJkvRk4pzhw3MtgpkWLfdfYEBXxTKYXqUqmHewgBTLf
        br2KTQemYCXN37/a6GLellBsKRsW4k+atQ==
X-Google-Smtp-Source: AGHT+IHThztIXQ4dGv4WndZH/hW7Siw0FXeg/Ryy8kEObDYRhHDAfNluZUZya/J6GI3MlfFNfpTm/Q==
X-Received: by 2002:a05:600c:ac4:b0:3fa:77ed:9894 with SMTP id c4-20020a05600c0ac400b003fa77ed9894mr11339819wmr.7.1694530825870;
        Tue, 12 Sep 2023 08:00:25 -0700 (PDT)
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id b12-20020a05600010cc00b0031431fb40fasm13148415wrx.89.2023.09.12.08.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 08:00:25 -0700 (PDT)
Message-ID: <82d97565-ebb4-806c-70ba-c0fec16d51d5@gmail.com>
Date:   Tue, 12 Sep 2023 16:00:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH][next] bcachefs: Fix a handful of spelling mistakes in
 various messages
Content-Language: en-US
To:     Brian Foster <bfoster@redhat.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230912082527.3913330-1-colin.i.king@gmail.com>
 <ZQBs2yEEupnoa2ZI@bfoster>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <ZQBs2yEEupnoa2ZI@bfoster>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 14:51, Brian Foster wrote:
> On Tue, Sep 12, 2023 at 09:25:27AM +0100, Colin Ian King wrote:
>> There are several spelling mistakes in error messages. Fix these.
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
>>   fs/bcachefs/alloc_background.c | 2 +-
>>   fs/bcachefs/backpointers.c     | 2 +-
>>   fs/bcachefs/btree_iter.c       | 2 +-
>>   fs/bcachefs/fsck.c             | 2 +-
>>   fs/bcachefs/recovery.c         | 2 +-
>>   fs/bcachefs/snapshot.c         | 2 +-
>>   fs/bcachefs/super-io.c         | 2 +-
>>   7 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/bcachefs/alloc_background.c b/fs/bcachefs/alloc_background.c
>> index 540d94c0cceb..dd9f3cbace1e 100644
>> --- a/fs/bcachefs/alloc_background.c
>> +++ b/fs/bcachefs/alloc_background.c
>> @@ -1247,7 +1247,7 @@ static noinline_for_stack int __bch2_check_discard_freespace_key(struct btree_tr
>>   		return ret;
>>   
>>   	if (fsck_err_on(!bch2_dev_bucket_exists(c, pos), c,
>> -			"entry in %s btree for nonexistant dev:bucket %llu:%llu",
>> +			"entry in %s btree for non-existent dev:bucket %llu:%llu",
> 
> "nonexistent" doesn't necessarily need to be hyphenated, right?

either way is valid, but some folk prefer the hyphenated version as it's 
apparently easier to scan.

> 
> Not that I really care ;), just curious. I'm sure Kent can massage or
> not if desired:
> 
> Reviewed-by: Brian Foster <bfoster@redhat.com>
> 
>>   			bch2_btree_ids[iter->btree_id], pos.inode, pos.offset))
>>   		goto delete;
>>   
>> diff --git a/fs/bcachefs/backpointers.c b/fs/bcachefs/backpointers.c
>> index 8747c5e19f99..bec62e5b21e5 100644
>> --- a/fs/bcachefs/backpointers.c
>> +++ b/fs/bcachefs/backpointers.c
>> @@ -357,7 +357,7 @@ static int bch2_check_btree_backpointer(struct btree_trans *trans, struct btree_
>>   	int ret = 0;
>>   
>>   	if (fsck_err_on(!bch2_dev_exists2(c, k.k->p.inode), c,
>> -			"backpointer for mising device:\n%s",
>> +			"backpointer for missing device:\n%s",
>>   			(bch2_bkey_val_to_text(&buf, c, k), buf.buf))) {
>>   		ret = bch2_btree_delete_at(trans, bp_iter, 0);
>>   		goto out;
>> diff --git a/fs/bcachefs/btree_iter.c b/fs/bcachefs/btree_iter.c
>> index 1dbb4d7dfb45..8d089bbdb1e5 100644
>> --- a/fs/bcachefs/btree_iter.c
>> +++ b/fs/bcachefs/btree_iter.c
>> @@ -1495,7 +1495,7 @@ static void bch2_trans_update_max_paths(struct btree_trans *trans)
>>   static noinline void btree_path_overflow(struct btree_trans *trans)
>>   {
>>   	bch2_dump_trans_paths_updates(trans);
>> -	panic("trans path oveflow\n");
>> +	panic("trans path overflow\n");
>>   }
>>   
>>   static inline struct btree_path *btree_path_alloc(struct btree_trans *trans,
>> diff --git a/fs/bcachefs/fsck.c b/fs/bcachefs/fsck.c
>> index 238caeeaf06c..cc04d5a22f40 100644
>> --- a/fs/bcachefs/fsck.c
>> +++ b/fs/bcachefs/fsck.c
>> @@ -80,7 +80,7 @@ static int __snapshot_lookup_subvol(struct btree_trans *trans, u32 snapshot,
>>   	if (!ret)
>>   		*subvol = le32_to_cpu(s.subvol);
>>   	else if (bch2_err_matches(ret, ENOENT))
>> -		bch_err(trans->c, "snapshot %u not fonud", snapshot);
>> +		bch_err(trans->c, "snapshot %u not found", snapshot);
>>   	return ret;
>>   
>>   }
>> diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
>> index 30efb3c90560..a78f5d023ef2 100644
>> --- a/fs/bcachefs/recovery.c
>> +++ b/fs/bcachefs/recovery.c
>> @@ -561,7 +561,7 @@ static void check_version_upgrade(struct bch_fs *c)
>>   			if ((recovery_passes & RECOVERY_PASS_ALL_FSCK) == RECOVERY_PASS_ALL_FSCK)
>>   				prt_str(&buf, "fsck required");
>>   			else {
>> -				prt_str(&buf, "running recovery passses: ");
>> +				prt_str(&buf, "running recovery passes: ");
>>   				prt_bitflags(&buf, bch2_recovery_passes, recovery_passes);
>>   			}
>>   
>> diff --git a/fs/bcachefs/snapshot.c b/fs/bcachefs/snapshot.c
>> index 9da09911466e..c2af574acb7c 100644
>> --- a/fs/bcachefs/snapshot.c
>> +++ b/fs/bcachefs/snapshot.c
>> @@ -1385,7 +1385,7 @@ int bch2_delete_dead_snapshots(struct bch_fs *c)
>>   	if (!test_bit(BCH_FS_STARTED, &c->flags)) {
>>   		ret = bch2_fs_read_write_early(c);
>>   		if (ret) {
>> -			bch_err(c, "error deleleting dead snapshots: error going rw: %s", bch2_err_str(ret));
>> +			bch_err(c, "error deleting dead snapshots: error going rw: %s", bch2_err_str(ret));
>>   			return ret;
>>   		}
>>   	}
>> diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
>> index f01883e785a5..6efd279655ae 100644
>> --- a/fs/bcachefs/super-io.c
>> +++ b/fs/bcachefs/super-io.c
>> @@ -385,7 +385,7 @@ static int bch2_sb_validate(struct bch_sb_handle *disk_sb, struct printbuf *out,
>>   	}
>>   
>>   	if (bch2_is_zero(sb->uuid.b, sizeof(sb->uuid))) {
>> -		prt_printf(out, "Bad intenal UUID (got zeroes)");
>> +		prt_printf(out, "Bad internal UUID (got zeroes)");
>>   		return -BCH_ERR_invalid_sb_uuid;
>>   	}
>>   
>> -- 
>> 2.39.2
>>
> 

