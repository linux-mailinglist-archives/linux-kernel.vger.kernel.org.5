Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B707A8080B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377467AbjLGGbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGGbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:31:49 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F1C10D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 22:31:54 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5c1f8b0c149so388354a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 22:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701930714; x=1702535514; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sR3A/v+kbUHDSu2DdKsZWsAH0wB0wI+BlWPsNGRqLQ=;
        b=w/HO0722I0VJSI72nJ/NFY9fPObBJN9xOa0PBadXZ8LRZai+KiFEeaPJKxTs0LtQ8p
         zjOcJQld4y33RWihJLiTCrQIA7DItMYajG1szjm9x+Od8y5oYUKSGxXtyuGoNmo+KcqG
         RrimeWCQ2QawNy7zQoXjzySrdU0PkMKUU68g5xAS+PxvaBo5Exdx5lBgjrKp1kvPGhvb
         qa/m33BsolzF0+F1nkoMNVlzc4V3abervsK2AcN9v5qG0hvUFQvimqFF+k7VONoDAYib
         R8d7IqLpsPPlkcIykv27MRLxdivMzKWzUmmkSvh+h0VxvwH5tzE2PKxZMcxgkOV71Pnr
         Ipag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701930714; x=1702535514;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sR3A/v+kbUHDSu2DdKsZWsAH0wB0wI+BlWPsNGRqLQ=;
        b=tcl8yz7Net/0yYETadhUGtUCk0OezFZfr7Zg548mxhRWUIAnnIpv93fKtDLMGiXRG+
         Dlj+ZuaA09hnchFFAHxzs6au2Fj6hoeABl6YUU7CG2B/bzNnnGp9BacOMngYh0Amz2YN
         zkHTIjqAgW0938T1hDPhr90mPIGjg+F+FhtIvxmVLtbJSyCseRNIZmAFltv+kEVEZcBn
         0DMET30y9vssyxo7GZ+U/iu1gHPDU644vPv2NJjR/0tFnCKruRdmzC3KFWlJ4+58WjcT
         7QG8cPJTKiJ6MtTp791So+bhV3KuUAPcNlCLxkH0Fo/eeBXnZxOlhtLByNAMa0CBhCsk
         SrFA==
X-Gm-Message-State: AOJu0Yw7E9Qhl3dQjWqVSxdCNlbHUnojXAs66s9ILRd0s+5NQtR4X8cQ
        I2osQj8SDqgszcRdhevqDNaheA==
X-Google-Smtp-Source: AGHT+IHWsp+cfB9xi7HfXzH6TBDYcA1Sv3F4kq9Lyt5FMc318rXqB8lIbQ2rOqVehb755XG/q1yIjg==
X-Received: by 2002:a05:6a21:3102:b0:18f:97c:ba21 with SMTP id yz2-20020a056a21310200b0018f097cba21mr2387789pzb.123.1701930713440;
        Wed, 06 Dec 2023 22:31:53 -0800 (PST)
Received: from smtpclient.apple ([103.172.41.205])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902b68700b001ca86a9caccsm521331pls.228.2023.12.06.22.31.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2023 22:31:53 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
From:   Li Feng <fengli@smartx.com>
In-Reply-To: <CACGkMEt4_T5-aArkS4LOQsndwrMkjm_K-uPjdFnNRvwknQPaPg@mail.gmail.com>
Date:   Thu, 7 Dec 2023 14:32:43 +0800
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO BLOCK AND SCSI DRIVERS" 
        <virtualization@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ABA117F8-58AA-40EC-B3DA-4AB000A72BAD@smartx.com>
References: <20231207043118.118158-1-fengli@smartx.com>
 <CACGkMEt4_T5-aArkS4LOQsndwrMkjm_K-uPjdFnNRvwknQPaPg@mail.gmail.com>
To:     Jason Wang <jasowang@redhat.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 7, 2023, at 14:02, Jason Wang <jasowang@redhat.com> wrote:
>=20
> On Thu, Dec 7, 2023 at 12:33=E2=80=AFPM Li Feng <fengli@smartx.com> =
wrote:
>>=20
>> virtio-blk is generally used in cloud computing scenarios, where the
>> performance of virtual disks is very important. The mq-deadline =
scheduler
>> has a big performance drop compared to none with single queue.
>=20
> At least you can choose the scheduler based on if mq is supported or =
not?
>=20
> Thanks
>=20
The "none" scheduler has better performance regardless of whether it is
a single queue or multiple queues. Why not set the single queue =
scheduler
to none by default?

Thanks.


