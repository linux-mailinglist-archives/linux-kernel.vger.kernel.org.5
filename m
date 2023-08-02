Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A817F76CAA3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjHBKUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjHBKUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:20:13 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7912685
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:20:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso4940175e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 03:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1690971610; x=1691576410;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=z4rJUp9E40rL5+8CP32mycBdPuI07UiAoVNbdysH/2w=;
        b=IHZHoNJee0qngDGi7rgLFsu2Fj3ALWVZqdunZfkstaFa3525boASabLF5QNjW/aDLh
         Wb1HSXHuoj0HRIpsriTPJoocccS4SdS6rNVWiuR8pt4I9tm3VjGN6Qyr8oXsYyACZryt
         qUbxszJNfgNIeGkLvg2LE7M9/piNcPmHx5pdOLgCKECr6CIAylmmAxxMnHY5N586RGtG
         dm4AKWtC8wdaV+ktiEZddrna0uwdSau4gXLHsddTHKH0UTrUYkqxzezp1zuPbbn0S7CP
         bhZYTPDEdnrj4Gatz5BqoGjlObqw90upHoOmmz61UCPUzwidEm0XBMIC4MinoZ6yQPCE
         fB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690971610; x=1691576410;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4rJUp9E40rL5+8CP32mycBdPuI07UiAoVNbdysH/2w=;
        b=WJRKA9pwVfLEybeMJk6onRigB9pmGqFag1GK7qfCHQ3BIeBrmPfOI9dS3TdUIG61HA
         GiySxnAxKQbbLIMzdVuiNc2QuZ15ablWpedjWVbs48/dD0ct2ZYnxPCcw1fIROkOO9YB
         kyLRW+GBqiMaUB/u0/GFY/RNWRVc7HpXc2J8LQTJ6zQgv60yicL/5aXj3aAQmxCb/UMy
         FkqHQLxFriLYzIlW86Q9K4a00jsbDjt0mlMTk3NczYXI7i6AmaDGOZ31C47mDtFoHsYa
         1jix2EK8vN/5G0tvdh0S2q10FzA3v5x4jdSlKCd2u5FM+sd3jJo8To3zWih8NByr2rJc
         9ttg==
X-Gm-Message-State: ABy/qLZSVIPO0X2sOcovoumY4WZHawM4AD56uczzdzZA9Q3BBkIwUJ4+
        juaYO0Bw4qhwyeqSfeOQ8Gg5OA==
X-Google-Smtp-Source: APBJJlFo+ohuERZxmfjaTrMzYUhCBVxfbYhKnGmeFRtFDL8Dh535ATJwmkvaXoavUylHY7WzkW7zkA==
X-Received: by 2002:a05:600c:4792:b0:3fe:21f1:aba8 with SMTP id k18-20020a05600c479200b003fe21f1aba8mr4750448wmo.12.1690971609857;
        Wed, 02 Aug 2023 03:20:09 -0700 (PDT)
Received: from localhost ([165.225.194.216])
        by smtp.gmail.com with ESMTPSA id a13-20020a05600c224d00b003fc05b89e5bsm1253536wmm.34.2023.08.02.03.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 03:20:09 -0700 (PDT)
References: <20230714072510.47770-1-nmi@metaspace.dk>
 <20230714072510.47770-3-nmi@metaspace.dk>
 <ZLesM5flOn2aet8p@ovpn-8-17.pek2.redhat.com>
 <ZLfZ/I2O3d7V9v7d@ovpn-8-21.pek2.redhat.com>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Matias Bjorling <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, gost.dev@samsung.com,
        Christoph Hellwig <hch@infradead.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v9 2/2] ublk: enable zoned storage support
Date:   Wed, 02 Aug 2023 12:19:26 +0200
In-reply-to: <ZLfZ/I2O3d7V9v7d@ovpn-8-21.pek2.redhat.com>
Message-ID: <875y5xpwyv.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ming Lei <ming.lei@redhat.com> writes:

> On Wed, Jul 19, 2023 at 05:26:11PM +0800, Ming Lei wrote:
>> On Fri, Jul 14, 2023 at 09:25:10AM +0200, Andreas Hindborg wrote:
>> > From: Andreas Hindborg <a.hindborg@samsung.com>
>> > 
>> > Add zoned storage support to ublk: report_zones and operations:
>> >  - REQ_OP_ZONE_OPEN
>> >  - REQ_OP_ZONE_CLOSE
>> >  - REQ_OP_ZONE_FINISH
>> >  - REQ_OP_ZONE_RESET
>> >  - REQ_OP_ZONE_APPEND
>> > 
>> > The zone append feature uses the `addr` field of `struct ublksrv_io_cmd` to
>> > communicate ALBA back to the kernel. Therefore ublk must be used with the
>> > user copy feature (UBLK_F_USER_COPY) for zoned storage support to be
>> > available. Without this feature, ublk will not allow zoned storage support.
>> > 
>> > Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> > ---
>> 
>> ...
>> 
>> > +/*
>> > + * Construct a zone report. The report request is carried in `struct
>> > + * ublksrv_io_desc`. The `start_sector` field must be the first sector of a zone
>> > + * and shall indicate the first zone of the report. The `nr_sectors` shall
>> > + * indicate how many zones should be reported (divide by zone size to get number
>> > + * of zones in the report) and must be an integer multiple of the zone size. The
>> > + * report shall be delivered as a `struct blk_zone` array. To report fewer zones
>> > + * than requested, zero the last entry of the returned array.
>> > + */
>> > +#define		UBLK_IO_OP_REPORT_ZONES		18
>> 
>> Actually, I meant the following delta change in V8 comment, then the UAPI
>> looks more clean & readable wrt. reporting how many zones in UBLK_IO_OP_REPORT_ZONES
>> and reusing ublksrv_io_cmd->addr.
>> 
>> Otherwise, this patchset looks fine.
>> 
>> 
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 5698f4575e05..454c852ed328 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -70,7 +70,7 @@ struct ublk_rq_data {
>>  	struct kref ref;
>>  	__u64 sector;
>>  	__u32 operation;
>> -	__u32 nr_sectors;
>> +	__u32 nr_zones;
>>  };
>>  
>>  struct ublk_uring_cmd_pdu {
>> @@ -335,7 +335,7 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
>>  		pdu = blk_mq_rq_to_pdu(req);
>>  		pdu->operation = UBLK_IO_OP_REPORT_ZONES;
>>  		pdu->sector = sector;
>> -		pdu->nr_sectors = zones_in_request * zone_size_sectors;
>> +		pdu->nr_zones = zones_in_request;
>>  
>>  		ret = blk_rq_map_kern(disk->queue, req, buffer, buffer_length,
>>  					GFP_KERNEL);
>> @@ -404,7 +404,7 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
>>  		switch (ublk_op) {
>>  		case UBLK_IO_OP_REPORT_ZONES:
>>  			iod->op_flags = ublk_op | ublk_req_build_flags(req);
>> -			iod->nr_sectors = pdu->nr_sectors;
>> +			iod->nr_zones = pdu->nr_zones;
>>  			iod->start_sector = pdu->sector;
>>  			return BLK_STS_OK;
>>  		default:
>> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
>> index 4d97eb0f7d13..602a788a650e 100644
>> --- a/include/uapi/linux/ublk_cmd.h
>> +++ b/include/uapi/linux/ublk_cmd.h
>> @@ -249,11 +249,13 @@ struct ublksrv_ctrl_dev_info {
>>  /*
>>   * Construct a zone report. The report request is carried in `struct
>>   * ublksrv_io_desc`. The `start_sector` field must be the first sector of a zone
>> - * and shall indicate the first zone of the report. The `nr_sectors` shall
>> - * indicate how many zones should be reported (divide by zone size to get number
>> - * of zones in the report) and must be an integer multiple of the zone size. The
>> - * report shall be delivered as a `struct blk_zone` array. To report fewer zones
>> - * than requested, zero the last entry of the returned array.
>> + * and shall indicate the first zone of the report. The `nr_zones` shall
>> + * indicate how many zones should be reported at most. The report shall be
>> + * delivered as a `struct blk_zone` array. To report fewer zones than
>> + * requested, zero the last entry of the returned array.
>> + *
>> + * So related definitions(blk_zone, blk_zone_cond, blk_zone_type, ...) in
>> + * include/uapi/linux/blkzoned.h are part of ublk UAPI.
>>   */
>>  #define		UBLK_IO_OP_REPORT_ZONES		18
>>  
>> @@ -276,7 +278,10 @@ struct ublksrv_io_desc {
>>  	/* op: bit 0-7, flags: bit 8-31 */
>>  	__u32		op_flags;
>>  
>> -	__u32		nr_sectors;
>> +	union {
>> +		__u32		nr_sectors;
>> +		__u32		nr_zones; /* for UBLK_IO_OP_REPORT_ZONES only */
>> +	};
>>  
>>  	/* start sector for this io */
>>  	__u64		start_sector;
>> @@ -308,6 +313,12 @@ struct ublksrv_io_cmd {
>>  	/*
>>  	 * userspace buffer address in ublksrv daemon process, valid for
>>  	 * FETCH* command only
>> +	 *
>> +	 * This field shouldn't be used if UBLK_F_USER_COPY is enabled,
>> +	 * because userspace deals with data copy by pread()/pwrite() over
>> +	 * /dev/ublkcN. But in case of UBLK_F_ZONED, 'addr' is re-used to
>> +	 * pass back the allocated LBA for UBLK_IO_OP_ZONE_APPEND which
>> +	 * actually depends on UBLK_F_USER_COPY
>>  	 */
>>  	__u64	addr;
>
> Or use union to cover zoned_append_lba, and we still need above
> document about UBLK_F_USER_COPY & UBLK_F_ZONED uses.
>
> 	union {
> 		__u64	addr;
> 		__u64	zoned_append_lba;
> 	}
>

Thanks, I'll add this to the next version.

BR Andreas
