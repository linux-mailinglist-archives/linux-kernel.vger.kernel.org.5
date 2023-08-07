Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFBB771800
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 03:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjHGBqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 21:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjHGBqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 21:46:20 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848311713;
        Sun,  6 Aug 2023 18:46:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RJzgV53Lzz4f3xsV;
        Mon,  7 Aug 2023 09:46:14 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgD3GG3lTNBkWMF0AA--.35218S2;
        Mon, 07 Aug 2023 09:46:15 +0800 (CST)
Subject: Re: [PATCH v5 8/8] ext4: add first unit test for
 ext4_mb_new_blocks_simple in mballoc
To:     Ritesh Harjani <ritesh.list@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <87jzucw5l7.fsf@doe.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <fa68f2a4-e8f1-8856-0a99-736b70de0c52@huaweicloud.com>
Date:   Mon, 7 Aug 2023 09:46:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87jzucw5l7.fsf@doe.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgD3GG3lTNBkWMF0AA--.35218S2
X-Coremail-Antispam: 1UD129KBjvAXoWfGF15tr1UZF17JF1Utw1DWrg_yoW8Jw4DCo
        WxtF1xJa1xXrWUtrZ3A3s5X34Du3yDGF1UJw45urZxXF1ak3WY9F42kw47WF4xW3W8Cr12
        yas7Xa45AF48ursxn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUU5R7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 8/3/2023 10:41 PM, Ritesh Harjani wrote:
> Kemeng Shi <shikemeng@huaweicloud.com> writes:
> 
>> Here are prepared work:
>> 1. Include mballoc-test.c to mballoc.c to be able test static function
>> in mballoc.c.
>> 2. Implement static stub to avoid read IO to disk.
>> 3. Construct fake super_block. Only partial members are set, more members
>> will be set when more functions are tested.
>> Then unit test for ext4_mb_new_blocks_simple is added.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/ext4/mballoc-test.c | 323 +++++++++++++++++++++++++++++++++++++++++
>>  fs/ext4/mballoc.c      |   4 +
>>  2 files changed, 327 insertions(+)
>>  create mode 100644 fs/ext4/mballoc-test.c
>>
>> diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
>> new file mode 100644
>> index 000000000000..184e6cb2070f
>> --- /dev/null
>> +++ b/fs/ext4/mballoc-test.c
>> @@ -0,0 +1,323 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * KUnit test of ext4 multiblocks allocation.
>> + */
>> +
>> +#include <kunit/test.h>
>> +#include <kunit/static_stub.h>
>> +
>> +#include "ext4.h"
>> +
>> +struct mb_grp_ctx {
>> +	struct buffer_head bitmap_bh;
>> +	struct ext4_group_desc desc;
>> +	/* one group descriptor for each group descriptor for simplicity */
>> +	struct buffer_head gd_bh;
>> +};
> 
> I suppose desc and gd_bh are just the place holders so that
> ext4_mb_new_blocks_simple() doesn't fail right? Is there any other use
> of this? Because I don't see we initializing these.
> 
>> +
>> +struct mb_ctx {
>> +	struct mb_grp_ctx *grp_ctx;
>> +};
>> +
>> +struct fake_super_block {
>> +	struct super_block sb;
>> +	struct mb_ctx mb_ctx;
>> +};
>> +
>> +#define MB_CTX(_sb) (&(container_of((_sb), struct fake_super_block, sb)->mb_ctx))
>> +#define MB_GRP_CTX(_sb, _group) (&MB_CTX(_sb)->grp_ctx[_group])
>> +
>> +static struct super_block *alloc_fake_super_block(void)
>> +{
>> +	struct ext4_super_block *es = kzalloc(sizeof(*es), GFP_KERNEL);
>> +	struct ext4_sb_info *sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
>> +	struct fake_super_block *fsb = kzalloc(sizeof(*fsb), GFP_KERNEL);
>> +
>> +	if (fsb == NULL || sbi == NULL || es == NULL)
>> +		goto out;
>> +
>> +	sbi->s_es = es;
>> +	fsb->sb.s_fs_info = sbi;
>> +	return &fsb->sb;
>> +
>> +out:
>> +	kfree(fsb);
>> +	kfree(sbi);
>> +	kfree(es);
>> +	return NULL;
>> +}
>> +
>> +static void free_fake_super_block(struct super_block *sb)
>> +{
>> +	struct fake_super_block *fsb = container_of(sb, struct fake_super_block, sb);
>> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
>> +
>> +	kfree(sbi->s_es);
>> +	kfree(sbi);
>> +	kfree(fsb);
>> +}
>> +
>> +struct ext4_block_layout {
>> +	unsigned char blocksize_bits;
>> +	unsigned int cluster_bits;
>> +	unsigned long blocks_per_group;
>> +	ext4_group_t group_count;
>> +	unsigned long desc_size;
>> +};
>> +
>> +static void init_sb_layout(struct super_block *sb,
>> +			  struct ext4_block_layout *layout)
>> +{
>> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
>> +	struct ext4_super_block *es = sbi->s_es;
>> +
>> +	sb->s_blocksize = 1UL << layout->blocksize_bits;
>> +	sb->s_blocksize_bits = layout->blocksize_bits;
>> +
>> +	sbi->s_groups_count = layout->group_count;
>> +	sbi->s_blocks_per_group = layout->blocks_per_group;
>> +	sbi->s_cluster_bits = layout->cluster_bits;
>> +	sbi->s_cluster_ratio = 1U << layout->cluster_bits;
>> +	sbi->s_clusters_per_group = layout->blocks_per_group >>
>> +				    layout->cluster_bits;
>> +	sbi->s_desc_size = layout->desc_size;
>> +
>> +	es->s_first_data_block = cpu_to_le32(0);
>> +	es->s_blocks_count_lo = cpu_to_le32(layout->blocks_per_group *
>> +					    layout->group_count);
>> +}
>> +
>> +static int mb_grp_ctx_init(struct super_block *sb,
>> +			   struct mb_grp_ctx *grp_ctx)
>> +{
>> +	grp_ctx->bitmap_bh.b_data = kzalloc(EXT4_BLOCK_SIZE(sb), GFP_KERNEL);
>> +	if (grp_ctx->bitmap_bh.b_data == NULL)
>> +		return -ENOMEM;
>> +
>> +	get_bh(&grp_ctx->bitmap_bh);
>> +	get_bh(&grp_ctx->gd_bh);
>> +	return 0;
>> +}
>> +
>> +static void mb_grp_ctx_release(struct mb_grp_ctx *grp_ctx)
>> +{
>> +	kfree(grp_ctx->bitmap_bh.b_data);
>> +	grp_ctx->bitmap_bh.b_data = NULL;
> 
> No brelse() here?
>>> +}
>> +
>> +static void mb_ctx_mark_used(struct super_block *sb, ext4_group_t group,
>> +			     unsigned int start, unsigned int len)
>> +{
>> +	struct mb_grp_ctx *grp_ctx = MB_GRP_CTX(sb, group);
>> +
>> +	mb_set_bits(grp_ctx->bitmap_bh.b_data, start, len);
>> +}
>> +
>> +/* called after init_sb_layout */
>> +static int mb_ctx_init(struct super_block *sb)
>> +{
>> +	struct mb_ctx *ctx = MB_CTX(sb);
>> +	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
>> +
>> +	ctx->grp_ctx = kcalloc(ngroups, sizeof(struct mb_grp_ctx),
>> +			       GFP_KERNEL);
>> +	if (ctx->grp_ctx == NULL)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < ngroups; i++)
>> +		if (mb_grp_ctx_init(sb, &ctx->grp_ctx[i]))
>> +			goto out;
>> +
>> +	/*
>> +	 * first data block(first cluster in first group) is used by
>> +	 * metadata, mark it used to avoid to alloc data block at first
>> +	 * block which will fail ext4_sb_block_valid check.
>> +	 */
>> +	mb_set_bits(ctx->grp_ctx[0].bitmap_bh.b_data, 0, 1);
>> +
>> +	return 0;
>> +out:
>> +	while (i-- > 0)
>> +		mb_grp_ctx_release(&ctx->grp_ctx[i]);
>> +	kfree(ctx->grp_ctx);
>> +	return -ENOMEM;
>> +}
>> +
>> +static void mb_ctx_release(struct super_block *sb)
>> +{
>> +	struct mb_ctx *ctx = MB_CTX(sb);
>> +	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
>> +
>> +	for (i = 0; i < ngroups; i++)
>> +		mb_grp_ctx_release(&ctx->grp_ctx[i]);
>> +	kfree(ctx->grp_ctx);
>> +}
>> +
>> +static struct buffer_head *
>> +ext4_read_block_bitmap_nowait_stub(struct super_block *sb, ext4_group_t block_group,
>> +				   bool ignore_locked)
>> +{
>> +	struct mb_grp_ctx *grp_ctx = MB_GRP_CTX(sb, block_group);
>> +
>> +	get_bh(&grp_ctx->bitmap_bh);
> 
> I don't know how will you call brelse() for this?
> It should be ok anyways since it's not a real buffer_head. But may be it
> will be good to add a comment about it.
> 
Sure, but I'm considering to simply remove all get_bh for fake buffer_heador.
And comments will be added if these get_bhs are kept for some unkonw limitation.
>> +	return &grp_ctx->bitmap_bh;
>> +}
>> +
>> +static int ext4_wait_block_bitmap_stub(struct super_block *sb,
>> +				ext4_group_t block_group,
>> +				struct buffer_head *bh)
>> +{
>> +	return 0;
>> +}
>> +
>> +static struct ext4_group_desc *
>> +ext4_get_group_desc_stub(struct super_block *sb, ext4_group_t block_group,
>> +			 struct buffer_head **bh)
>> +{
>> +	struct mb_grp_ctx *grp_ctx = MB_GRP_CTX(sb, block_group);
>> +
>> +	if (bh != NULL)
>> +		*bh = &grp_ctx->gd_bh;
>> +
>> +	return &grp_ctx->desc;
>> +}
>> +
>> +static int ext4_mb_mark_group_bb_stub(struct ext4_mark_context *mc,
>> +			       ext4_group_t group, ext4_grpblk_t blkoff,
>> +			       ext4_grpblk_t len, int flags)
>> +{
>> +	struct mb_grp_ctx *grp_ctx = MB_GRP_CTX(mc->sb, group);
>> +	struct buffer_head *bitmap_bh = &grp_ctx->bitmap_bh;
>> +
>> +	if (mc->state)
>> +		mb_set_bits(bitmap_bh->b_data, blkoff, len);
>> +	else
>> +		mb_clear_bits(bitmap_bh->b_data, blkoff, len);
>> +
>> +	return 0;
>> +}
>> +
>> +#define TEST_BLOCKSIZE_BITS 10
>> +#define TEST_CLUSTER_BITS 3
>> +#define TEST_BLOCKS_PER_GROUP 8192
>> +#define TEST_GROUP_COUNT 4
>> +#define TEST_DESC_SIZE 64
>> +#define TEST_GOAL_GROUP 1
> 
> Rather then defining this statically, can we add a test for testing
> different options. like for e.g. bs=1k, 4k, and 64k to be tested in a
> loop or something with maybe diffrent group_count values to start with? 
> 
Yes, it looks better in this way. I will add several configures to test.
> At a high level, I went over the code and this looks like a good
> first start to me. One suggestion is to prefix the mballoc kunit tests
> with some string to differentiate what is kunit related and what is
> actual ext4/mballoc calls. Once this kunit test grows, I am sure it will
> be difficult to make out the differece between test related APIs and
> actual kernel APIs.
> 
> maybe something like mbt_
> 
> so mb_grp_ctx -> mbt_grp_ctx
> mb_ctx -> mbt_ctx
> fake_super_block -> mbt_ext4_super_block
> alloc/free_fake_super_block -> mbt_ext4_alloc/free_super_block
> 
> ext4_block_layout -> mbt_ext4_block_layout
> 
> init_sb_layout -> mbt_init_sb_layout
> 
> mb_grp_ctx_init/release -> mbt_grp_ctx_init/release
> mb_ctx_mark_used -> mbt_ctx_mark_used
> 
> mballoc_test_init -> mbt_kunit_init
> ext4_mballoc_test_cases -> mbt_test_cases 
> 
Sure, prefix mbt just looks good to me.
> funtions with _stub looks ok to me, as we can clearly differentiate them
> from actual functions. 
> 
> 
> -ritesh
> 
Thanks for all advices!
> 
>> +static int mballoc_test_init(struct kunit *test)
>> +{
>> +	struct ext4_block_layout layout = {
>> +		.blocksize_bits = TEST_BLOCKSIZE_BITS,
>> +		.cluster_bits = TEST_CLUSTER_BITS,
>> +		.blocks_per_group = TEST_BLOCKS_PER_GROUP,
>> +		.group_count = TEST_GROUP_COUNT,
>> +		.desc_size = TEST_DESC_SIZE,
>> +	};
>> +	struct super_block *sb;
>> +	int ret;
>> +
>> +	sb = alloc_fake_super_block();
>> +	if (sb == NULL)
>> +		return -ENOMEM;
>> +
>> +	init_sb_layout(sb, &layout);
>> +
>> +	ret = mb_ctx_init(sb);
>> +	if (ret != 0) {
>> +		free_fake_super_block(sb);
>> +		return ret;
>> +	}
>> +
>> +	test->priv = sb;
>> +	kunit_activate_static_stub(test,
>> +				   ext4_read_block_bitmap_nowait,
>> +				   ext4_read_block_bitmap_nowait_stub);
>> +	kunit_activate_static_stub(test,
>> +				   ext4_wait_block_bitmap,
>> +				   ext4_wait_block_bitmap_stub);
>> +	kunit_activate_static_stub(test,
>> +				   ext4_get_group_desc,
>> +				   ext4_get_group_desc_stub);
>> +	kunit_activate_static_stub(test,
>> +				   ext4_mb_mark_group_bb,
>> +				   ext4_mb_mark_group_bb_stub);
>> +	return 0;
>> +}
>> +
>> +static void mballoc_test_exit(struct kunit *test)
>> +{
>> +	struct super_block *sb = (struct super_block *)test->priv;
>> +
>> +	mb_ctx_release(sb);
>> +	free_fake_super_block(sb);
>> +}
>> +
>> +static void test_new_blocks_simple(struct kunit *test)
>> +{
>> +	struct super_block *sb = (struct super_block *)test->priv;
>> +	struct inode inode = { .i_sb = sb, };
>> +	struct ext4_allocation_request ar;
>> +	ext4_group_t i, goal_group = TEST_GOAL_GROUP;
>> +	int err = 0;
>> +	ext4_fsblk_t found;
>> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
>> +
>> +	ar.inode = &inode;
>> +
>> +	/* get block at goal */
>> +	ar.goal = ext4_group_first_block_no(sb, goal_group);
>> +	found = ext4_mb_new_blocks_simple(&ar, &err);
>> +	KUNIT_ASSERT_EQ_MSG(test, ar.goal, found,
>> +		"failed to alloc block at goal, expected %llu found %llu",
>> +		ar.goal, found);
>> +
>> +	/* get block after goal in goal group */
>> +	ar.goal = ext4_group_first_block_no(sb, goal_group);
>> +	found = ext4_mb_new_blocks_simple(&ar, &err);
>> +	KUNIT_ASSERT_EQ_MSG(test, ar.goal + EXT4_C2B(sbi, 1), found,
>> +		"failed to alloc block after goal in goal group, expected %llu found %llu",
>> +		ar.goal + 1, found);
>> +
>> +	/* get block after goal group */
>> +	mb_ctx_mark_used(sb, goal_group, 0, EXT4_CLUSTERS_PER_GROUP(sb));
>> +	ar.goal = ext4_group_first_block_no(sb, goal_group);
>> +	found = ext4_mb_new_blocks_simple(&ar, &err);
>> +	KUNIT_ASSERT_EQ_MSG(test,
>> +		ext4_group_first_block_no(sb, goal_group + 1), found,
>> +		"failed to alloc block after goal group, expected %llu found %llu",
>> +		ext4_group_first_block_no(sb, goal_group + 1), found);
>> +
>> +	/* get block before goal group */
>> +	for (i = goal_group; i < ext4_get_groups_count(sb); i++)
>> +		mb_ctx_mark_used(sb, i, 0, EXT4_CLUSTERS_PER_GROUP(sb));
>> +	ar.goal = ext4_group_first_block_no(sb, goal_group);
>> +	found = ext4_mb_new_blocks_simple(&ar, &err);
>> +	KUNIT_ASSERT_EQ_MSG(test,
>> +		ext4_group_first_block_no(sb, 0) + EXT4_C2B(sbi, 1), found,
>> +		"failed to alloc block before goal group, expected %llu found %llu",
>> +		ext4_group_first_block_no(sb, 0 + EXT4_C2B(sbi, 1)), found);
>> +
>> +	/* no block available, fail to allocate block */
>> +	for (i = 0; i < ext4_get_groups_count(sb); i++)
>> +		mb_ctx_mark_used(sb, i, 0, EXT4_CLUSTERS_PER_GROUP(sb));
>> +	ar.goal = ext4_group_first_block_no(sb, goal_group);
>> +	found = ext4_mb_new_blocks_simple(&ar, &err);
>> +	KUNIT_ASSERT_NE_MSG(test, err, 0,
>> +		"unexpectedly get block when no block is available");
>> +}
>> +
>> +
>> +static struct kunit_case ext4_mballoc_test_cases[] = {
>> +	KUNIT_CASE(test_new_blocks_simple),
>> +	{}
>> +};
>> +
>> +static struct kunit_suite ext4_mballoc_test_suite = {
>> +	.name = "ext4_mballoc_test",
>> +	.init = mballoc_test_init,
>> +	.exit = mballoc_test_exit,
>> +	.test_cases = ext4_mballoc_test_cases,
>> +};
>> +
>> +kunit_test_suites(&ext4_mballoc_test_suite);
>> +
>> +MODULE_LICENSE("GPL");
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index dd2fc0546c0b..b6b963412cdc 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -6954,3 +6954,7 @@ ext4_mballoc_query_range(
>>  
>>  	return error;
>>  }
>> +
>> +#ifdef CONFIG_EXT4_KUNIT_TESTS
>> +#include "mballoc-test.c"
>> +#endif
>> -- 
>> 2.30.0
> 

-- 
Best wishes
Kemeng Shi

