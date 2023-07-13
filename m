Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA994753245
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjGNGuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjGNGuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:50:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE35D1BEB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:50:00 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso2697371e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1689317399; x=1689922199;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFEHL9IU7WUZSxPKnuAVTIBVExYQF7gvRTAq6Os+/UA=;
        b=RAYDKwy/QjgwIYTJvmwV+42iJKenWMNJALKuF4eI5YDLissvuSRVfgQXuXRGWoU2Ry
         SaT0Vm8GjwRYY9R3YDm/qOc7e10pkNd6j9u0UHYa2iWji47oF9JNCVFywWBSTGCaXY2n
         rQrz/08y46xoUQAdniDHtCHPDAzvCCsAW4logAuFTKk88DerTwHqhu86J6RntDmob+ZF
         ALWMvwX6Lvg8Zo/YLE+2dfmAtcypnnom1ggqYw0GzK3s5cQRYfHRW/vjDY6nQzE7nlXL
         G8qkj7zWAgPJ9RxPXBTOyh9TyX6/WBAiqWKQiGYgN5Jn4kpNe2P/Z7KegxH5cCwwmzHR
         lW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689317399; x=1689922199;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KFEHL9IU7WUZSxPKnuAVTIBVExYQF7gvRTAq6Os+/UA=;
        b=iibVqvg2ZHFXrQqmMJ6hn7HTHmN5azJRQ8hIyXNe392GwNbV8JcwWvlF53w8vC5JFG
         47xwe3+WTaF3NrvJ3+DYxdBBUIL+v+fdRm/zLWg5Fn75cMzlm+nRoqCUtuKPh6ke1tpq
         6EvrsgAOxbxBREEGXT+gsuChv+53YklQLrGfGbxrRolTQPOd5RJpKl0o0ec9WJkAWziq
         5hoHd+MR9qQ2kyV5ve4p0yJOMcjp1gemmpkkzpuQx9Q/bJFZlbpkaLULifNoCXBPr9j4
         Nh3E6qDSY4Bg6gDu+NMqm9I5bdVv3Y52DMItxxoakllU5g/U2lU5OQ4EPjvxljGEhzG9
         XD/Q==
X-Gm-Message-State: ABy/qLb8LGF+AkRlmphsI4bBUEru84wNihFbqhWro3hwhY/CRguNOod2
        QV/Prpf8mJ64972T7tI4kHAH8g==
X-Google-Smtp-Source: APBJJlGB4PvIEGNo9JNzReDwXSfw1QeJS60K9puN3WzVD9CwtRD/LQ58YjUMSlk4eDwVTV4Agwk06A==
X-Received: by 2002:a05:6512:3712:b0:4f8:66e1:14e3 with SMTP id z18-20020a056512371200b004f866e114e3mr2906208lfr.17.1689317398552;
        Thu, 13 Jul 2023 23:49:58 -0700 (PDT)
Received: from localhost ([185.108.254.55])
        by smtp.gmail.com with ESMTPSA id b9-20020a056512218900b004f640b0fb04sm1353321lft.212.2023.07.13.23.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 23:49:58 -0700 (PDT)
References: <20230711072353.200873-1-nmi@metaspace.dk>
 <20230711072353.200873-3-nmi@metaspace.dk>
 <ZK7HgY9Wt4OT1fjX@ovpn-8-25.pek2.redhat.com>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        open list <linux-kernel@vger.kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH v8 2/2] ublk: enable zoned storage support
Date:   Thu, 13 Jul 2023 08:41:33 +0200
In-reply-to: <ZK7HgY9Wt4OT1fjX@ovpn-8-25.pek2.redhat.com>
Message-ID: <871qhbxa0m.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ming Lei <ming.lei@redhat.com> writes:

> On Tue, Jul 11, 2023 at 09:23:53AM +0200, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>=20
>> Add zoned storage support to ublk: report_zones and operations:
>>  - REQ_OP_ZONE_OPEN
>>  - REQ_OP_ZONE_CLOSE
>>  - REQ_OP_ZONE_FINISH
>>  - REQ_OP_ZONE_RESET
>>  - REQ_OP_ZONE_APPEND
>>=20
>> The zone append feature uses the `addr` field of `struct ublksrv_io_cmd`=
 to
>> communicate ALBA back to the kernel. Therefore ublk must be used with the
>> user copy feature (UBLK_F_USER_COPY) for zoned storage support to be
>> available. Without this feature, ublk will not allow zoned storage suppo=
rt.
>
> Without one userspace implementation, it is hard to verify the kernel
> change, so I write one zoned target example based on libublk-rs by
> taking one day.
>
> https://github.com/ming1/libublk-rs.git [1]
>
> It is one zoned-ramdisk example, and should be easy to
> add persistence zoned. All zoned commands are covered, except for
> REQ_OP_ZONE_RESET_ALL.
>
> How to create ublk-zoned:
>
> 	cargo run --example zoned -- add -1 1024   #1024MB
>
> So far it passes all blktests/zbd tests for external zoned device.
>
> 'mkfs.btrfs -O zoned' & mount & git clone linux_kernel in this btrfs
> works.
>
> So this patchset gets verified now, so far so good.

Thanks, that is really awesome! I have been testing with a patched
version of ubdsrv. It's nice to get some more test coverage options.

>
> [1] not publish to crates.io yet, still need some cleanup
>
>>=20
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> ---
>>  drivers/block/ublk_drv.c      | 314 ++++++++++++++++++++++++++++++++--
>>  include/uapi/linux/ublk_cmd.h |  36 +++-
>>  2 files changed, 331 insertions(+), 19 deletions(-)
>>=20
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 8d271901efac..a57be961b708 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -56,16 +56,21 @@
>>  		| UBLK_F_USER_RECOVERY_REISSUE \
>>  		| UBLK_F_UNPRIVILEGED_DEV \
>>  		| UBLK_F_CMD_IOCTL_ENCODE \
>> -		| UBLK_F_USER_COPY)
>> +		| UBLK_F_USER_COPY \
>> +		| UBLK_F_ZONED)
>>=20=20
>>  /* All UBLK_PARAM_TYPE_* should be included here */
>> -#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
>> -		UBLK_PARAM_TYPE_DISCARD | UBLK_PARAM_TYPE_DEVT)
>> +#define UBLK_PARAM_TYPE_ALL                                \
>> +	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
>> +	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED)
>>=20=20
>>  struct ublk_rq_data {
>>  	struct llist_node node;
>>=20=20
>>  	struct kref ref;
>> +	__u64 sector;
>> +	__u32 operation;
>> +	__u32 nr_sectors;
>>  };
>>=20=20
>>  struct ublk_uring_cmd_pdu {
>> @@ -110,6 +115,11 @@ struct ublk_uring_cmd_pdu {
>>   */
>>  #define UBLK_IO_FLAG_NEED_GET_DATA 0x08
>>=20=20
>> +/*
>> + * Set when IO is Zone Append
>> + */
>> +#define UBLK_IO_FLAG_ZONE_APPEND 0x10
>> +
>>  struct ublk_io {
>>  	/* userspace buffer address from io cmd */
>>  	__u64	addr;
>> @@ -190,6 +200,198 @@ static inline bool ublk_dev_is_user_copy(const str=
uct ublk_device *ub)
>>  	return ub->dev_info.flags & UBLK_F_USER_COPY;
>>  }
>>=20=20
>> +static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
>> +{
>> +	return ub->dev_info.flags & UBLK_F_ZONED;
>> +}
>> +
>> +static inline bool ublk_queue_is_zoned(struct ublk_queue *ubq)
>> +{
>> +	return ubq->flags & UBLK_F_ZONED;
>> +}
>> +
>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +
>> +static int ublk_get_nr_zones(const struct ublk_device *ub)
>> +{
>> +	const struct ublk_param_basic *p =3D &ub->params.basic;
>> +
>> +	/* Zone size is a power of 2 */
>> +	return p->dev_sectors >> ilog2(p->chunk_sectors);
>> +}
>> +
>> +static int ublk_revalidate_disk_zones(struct ublk_device *ub)
>> +{
>> +	return blk_revalidate_disk_zones(ub->ub_disk, NULL);
>> +}
>> +
>> +static int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
>> +{
>> +	const struct ublk_param_zoned *p =3D &ub->params.zoned;
>> +	int nr_zones;
>> +
>> +	if (!ublk_dev_is_zoned(ub))
>> +		return -EINVAL;
>> +
>> +	if (!p->max_zone_append_sectors)
>> +		return -EINVAL;
>> +
>> +	nr_zones =3D ublk_get_nr_zones(ub);
>> +
>> +	if (p->max_active_zones > nr_zones)
>> +		return -EINVAL;
>> +
>> +	if (p->max_open_zones > nr_zones)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ublk_dev_param_zoned_apply(struct ublk_device *ub)
>> +{
>> +	const struct ublk_param_zoned *p =3D &ub->params.zoned;
>> +
>> +	disk_set_zoned(ub->ub_disk, BLK_ZONED_HM);
>> +	blk_queue_required_elevator_features(ub->ub_disk->queue,
>> +					     ELEVATOR_F_ZBD_SEQ_WRITE);
>> +	disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
>> +	disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
>> +	blk_queue_max_zone_append_sectors(ub->ub_disk->queue, p->max_zone_appe=
nd_sectors);
>> +
>> +	ub->ub_disk->nr_zones =3D ublk_get_nr_zones(ub);
>> +
>> +	return 0;
>> +}
>> +
>> +/* Based on virtblk_alloc_report_buffer */
>> +static void *ublk_alloc_report_buffer(struct ublk_device *ublk,
>> +				      unsigned int nr_zones, size_t *buflen)
>> +{
>> +	struct request_queue *q =3D ublk->ub_disk->queue;
>> +	size_t bufsize;
>> +	void *buf;
>> +
>> +	nr_zones =3D min_t(unsigned int, nr_zones,
>> +			 ublk->ub_disk->nr_zones);
>> +
>> +	bufsize =3D nr_zones * sizeof(struct blk_zone);
>> +	bufsize =3D
>> +		min_t(size_t, bufsize, queue_max_hw_sectors(q) << SECTOR_SHIFT);
>> +	bufsize =3D min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT=
);
>
> 'bufsize' shouldn't related with queue_max_segments() given we don't
> enable segment limit yet.

Ok =F0=9F=91=8D

>
>> +
>> +	while (bufsize >=3D sizeof(struct blk_zone)) {
>> +		buf =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
>> +		if (buf) {
>> +			*buflen =3D bufsize;
>> +			return buf;
>> +		}
>> +		bufsize >>=3D 1;
>> +	}
>> +
>> +	*buflen =3D 0;
>> +	return NULL;
>> +}
>> +
>> +static int ublk_report_zones(struct gendisk *disk, sector_t sector,
>> +		      unsigned int nr_zones, report_zones_cb cb, void *data)
>> +{
>> +	struct ublk_device *ub =3D disk->private_data;
>> +	unsigned int zone_size_sectors =3D disk->queue->limits.chunk_sectors;
>> +	unsigned int first_zone =3D sector >> ilog2(zone_size_sectors);
>> +	unsigned int done_zones =3D 0;
>> +	unsigned int max_zones_per_request;
>> +	int ret;
>> +	struct blk_zone *buffer;
>> +	size_t buffer_length;
>> +
>> +	nr_zones =3D min_t(unsigned int, ub->ub_disk->nr_zones - first_zone,
>> +			 nr_zones);
>> +
>> +	buffer =3D ublk_alloc_report_buffer(ub, nr_zones, &buffer_length);
>> +	if (!buffer)
>> +		return -ENOMEM;
>> +
>> +	max_zones_per_request =3D buffer_length / sizeof(struct blk_zone);
>> +
>> +	while (done_zones < nr_zones) {
>> +		unsigned int remaining_zones =3D nr_zones - done_zones;
>> +		unsigned int zones_in_request =3D
>> +			min_t(unsigned int, remaining_zones, max_zones_per_request);
>> +		struct request *req;
>> +		struct ublk_rq_data *pdu;
>> +		blk_status_t status;
>> +
>> +		memset(buffer, 0, buffer_length);
>> +
>> +		req =3D blk_mq_alloc_request(disk->queue, REQ_OP_DRV_IN, 0);
>> +		if (IS_ERR(req)) {
>> +			ret =3D PTR_ERR(req);
>> +			goto out;
>> +		}
>> +
>> +		pdu =3D blk_mq_rq_to_pdu(req);
>> +		pdu->operation =3D UBLK_IO_OP_REPORT_ZONES;
>> +		pdu->sector =3D sector;
>> +		pdu->nr_sectors =3D remaining_zones * zone_size_sectors;
>
> pdu->nr_sectors will be set to ublksrv_io_desc->nr_sectors as part of
> UAPI, I feel it is hard to understand to pass 'remaining_zones * zone_siz=
e_sectors',
> probably it is fine to re-define as buffer size or requested
> nr_blk_zone, or other ideas?

This is the only place `pdu->nr_sectors` is assigned. We copy the value
to `iod->nr_sectors` when we process the request. So I think that part
is OK.

However, it should be set to `zones_in_request`, not `remaining_zones`.
Otherwise user space might try to write too much to the buffer and get
confused when the write fails.

>
>> +
>> +		ret =3D blk_rq_map_kern(disk->queue, req, buffer, buffer_length,
>> +					GFP_KERNEL);
>> +		if (ret) {
>> +			blk_mq_free_request(req);
>> +			goto out;
>> +		}
>> +
>> +		status =3D blk_execute_rq(req, 0);
>> +		ret =3D blk_status_to_errno(status);
>> +		blk_mq_free_request(req);
>> +		if (ret)
>> +			goto out;
>> +
>> +		for (unsigned int i =3D 0; i < zones_in_request; i++) {
>> +			struct blk_zone *zone =3D buffer + i;
>> +
>> +			/* A zero length zone means no more zones in this response */
>> +			if (!zone->len)
>> +				break;
>> +
>> +			ret =3D cb(zone, i, data);
>> +			if (ret)
>> +				goto out;
>> +
>> +			done_zones++;
>> +			sector +=3D zone_size_sectors;
>> +
>> +		}
>> +	}
>> +
>> +	ret =3D done_zones;
>> +
>> +out:
>> +	kvfree(buffer);
>> +	return ret;
>> +}
>> +
>> +#else
>> +
>> +#define ublk_report_zones (NULL)
>> +
>> +static int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int ublk_dev_param_zoned_apply(struct ublk_device *ub)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int ublk_revalidate_disk_zones(struct ublk_device *ub)
>> +{
>> +	return 0;
>> +}
>> +
>> +#endif
>> +
>>  static inline void __ublk_complete_rq(struct request *req);
>>  static void ublk_complete_rq(struct kref *ref);
>>=20=20
>> @@ -232,7 +434,7 @@ static inline unsigned ublk_pos_to_tag(loff_t pos)
>>  		UBLK_TAG_BITS_MASK;
>>  }
>>=20=20
>> -static void ublk_dev_param_basic_apply(struct ublk_device *ub)
>> +static int ublk_dev_param_basic_apply(struct ublk_device *ub)
>>  {
>>  	struct request_queue *q =3D ub->ub_disk->queue;
>>  	const struct ublk_param_basic *p =3D &ub->params.basic;
>> @@ -257,6 +459,8 @@ static void ublk_dev_param_basic_apply(struct ublk_d=
evice *ub)
>>  		set_disk_ro(ub->ub_disk, true);
>>=20=20
>>  	set_capacity(ub->ub_disk, p->dev_sectors);
>> +
>> +	return 0;
>>  }
>>=20=20
>>  static void ublk_dev_param_discard_apply(struct ublk_device *ub)
>> @@ -286,6 +490,9 @@ static int ublk_validate_params(const struct ublk_de=
vice *ub)
>>=20=20
>>  		if (p->max_sectors > (ub->dev_info.max_io_buf_bytes >> 9))
>>  			return -EINVAL;
>> +
>> +		if (ublk_dev_is_zoned(ub) && !p->chunk_sectors)
>> +			return -EINVAL;
>>  	} else
>>  		return -EINVAL;
>>=20=20
>> @@ -304,19 +511,31 @@ static int ublk_validate_params(const struct ublk_=
device *ub)
>>  	if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
>>  		return -EINVAL;
>>=20=20
>> +	if (ub->params.types & UBLK_PARAM_TYPE_ZONED)
>> +		return ublk_dev_param_zoned_validate(ub);
>> +	else if (ublk_dev_is_zoned(ub))
>> +		return -EINVAL;
>> +
>>  	return 0;
>>  }
>>=20=20
>>  static int ublk_apply_params(struct ublk_device *ub)
>>  {
>> +	int ret;
>> +
>>  	if (!(ub->params.types & UBLK_PARAM_TYPE_BASIC))
>>  		return -EINVAL;
>>=20=20
>> -	ublk_dev_param_basic_apply(ub);
>> +	ret =3D ublk_dev_param_basic_apply(ub);
>> +	if (ret)
>> +		return ret;
>>=20=20
>>  	if (ub->params.types & UBLK_PARAM_TYPE_DISCARD)
>>  		ublk_dev_param_discard_apply(ub);
>>=20=20
>> +	if (ub->params.types & UBLK_PARAM_TYPE_ZONED)
>> +		return ublk_dev_param_zoned_apply(ub);
>> +
>>  	return 0;
>>  }
>>=20=20
>> @@ -487,6 +706,7 @@ static const struct block_device_operations ub_fops =
=3D {
>>  	.owner =3D	THIS_MODULE,
>>  	.open =3D		ublk_open,
>>  	.free_disk =3D	ublk_free_disk,
>> +	.report_zones =3D	ublk_report_zones,
>>  };
>>=20=20
>>  #define UBLK_MAX_PIN_PAGES	32
>> @@ -601,7 +821,8 @@ static inline bool ublk_need_map_req(const struct re=
quest *req)
>>=20=20
>>  static inline bool ublk_need_unmap_req(const struct request *req)
>>  {
>> -	return ublk_rq_has_data(req) && req_op(req) =3D=3D REQ_OP_READ;
>> +	return ublk_rq_has_data(req) &&
>> +	       (req_op(req) =3D=3D REQ_OP_READ || req_op(req) =3D=3D REQ_OP_DR=
V_IN);
>>  }
>>=20=20
>>  static int ublk_map_io(const struct ublk_queue *ubq, const struct reque=
st *req,
>> @@ -685,8 +906,14 @@ static blk_status_t ublk_setup_iod(struct ublk_queu=
e *ubq, struct request *req)
>>  {
>>  	struct ublksrv_io_desc *iod =3D ublk_get_iod(ubq, req->tag);
>>  	struct ublk_io *io =3D &ubq->ios[req->tag];
>> +	struct ublk_rq_data *pdu =3D blk_mq_rq_to_pdu(req);
>> +	enum req_op op =3D req_op(req);
>>  	u32 ublk_op;
>>=20=20
>> +	if (!ublk_queue_is_zoned(ubq) &&
>> +	    (op_is_zone_mgmt(op) || op =3D=3D REQ_OP_ZONE_APPEND))
>> +		return -EIO;
>> +
>>  	switch (req_op(req)) {
>>  	case REQ_OP_READ:
>>  		ublk_op =3D UBLK_IO_OP_READ;
>> @@ -703,6 +930,37 @@ static blk_status_t ublk_setup_iod(struct ublk_queu=
e *ubq, struct request *req)
>>  	case REQ_OP_WRITE_ZEROES:
>>  		ublk_op =3D UBLK_IO_OP_WRITE_ZEROES;
>>  		break;
>> +	case REQ_OP_ZONE_OPEN:
>> +		ublk_op =3D UBLK_IO_OP_ZONE_OPEN;
>> +		break;
>> +	case REQ_OP_ZONE_CLOSE:
>> +		ublk_op =3D UBLK_IO_OP_ZONE_CLOSE;
>> +		break;
>> +	case REQ_OP_ZONE_FINISH:
>> +		ublk_op =3D UBLK_IO_OP_ZONE_FINISH;
>> +		break;
>> +	case REQ_OP_ZONE_RESET:
>> +		ublk_op =3D UBLK_IO_OP_ZONE_RESET;
>> +		break;
>> +	case REQ_OP_DRV_IN:
>> +		ublk_op =3D pdu->operation;
>> +		switch (ublk_op) {
>> +		case UBLK_IO_OP_REPORT_ZONES:
>> +			iod->op_flags =3D ublk_op | ublk_req_build_flags(req);
>> +			iod->nr_sectors =3D pdu->nr_sectors;
>> +			iod->start_sector =3D pdu->sector;
>> +			return BLK_STS_OK;
>> +		default:
>> +			return BLK_STS_IOERR;
>> +		}
>> +	case REQ_OP_ZONE_APPEND:
>> +		ublk_op =3D UBLK_IO_OP_ZONE_APPEND;
>> +		io->flags |=3D UBLK_IO_FLAG_ZONE_APPEND;
>> +		break;
>> +	case REQ_OP_ZONE_RESET_ALL:
>> +	case REQ_OP_DRV_OUT:
>> +		/* We do not support reset_all and drv_out */
>> +		return BLK_STS_NOTSUPP;
>
> I'd suggest to move all zoned handling & the above check into one helper,
> such as:
>
> 	default:
> 		if (ublk_queue_is_zoned())
> 			return ublk_zoned_setup_iod();
>
> Then zoned check can be avoided for other generic OPs, and zoned patch
> conflict could be avoided usually.

Alright =F0=9F=91=8D

Best regards,
Andreas
