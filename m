Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102667D1D10
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 14:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjJUMKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 08:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJUMKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 08:10:43 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC9CD5E
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 05:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpW81sFYUEdJ8ysRuNxS4wloviBIsHN0oQlFT1gtjtB3Z/e08/fejd+Drpy7bR6rJbY5v2cjlOxdT1lydWJRUGUYe5zDFTTY+fS/AVvJQyWiXGgMhOmPW1kATA3DMRZtrZTuUt1vL3rVka0PG37VqJtxtuJYbmqaoMMQYehV3mvtnsRuSKdhoByu0hMwj2ebhaZPxIaSXbHWtBv9jB2/GhJxi8FmJ7W/3CbfraUcEnjX/yzJtGvkpm+us0P8N7G+7uZaZbTVzUykL1D4NGV7rxlAYcj2XLmr8mPSqnB9q5xUnTpm42ZiYFA0DD84oKzJy3YzPbQ6AhAajZAcROcyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrAkJASjP1/wM4gaqP1JNjGCXp3ig3iBpV0HG/4fbrQ=;
 b=mLu13ZzW6nHqfEMMqY39A6XcPLJSdcm8YnIr+df5p846fHAa86RjlNE/3sP6d/KQwNdj6ExbLwfJjJ85bK0k2CBM64yVPERz8Y8vVh/B5XfMMXG0OHyomYf5y1dG45OgsLjAVYEAQDG6/otACkY8GJqRGzB4EoG7VuFqac4ztwuNaPXcoP8X8TJIO/BMu1WW9e7K3D7DsfcV8L8vHIqb3fCVTIfBm+qrWL2Qd1zAHEpftDKvvHsVJbZXcjzR6nSTutbxZAs3cWvjDJXbTDGS/gxPGXKePvRZpK4u2NbxnjzWnIYq6hhULJN5EloPxw0qspP5W5Cz1dE4+84UDxJXLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrAkJASjP1/wM4gaqP1JNjGCXp3ig3iBpV0HG/4fbrQ=;
 b=b00eXrvhRJbvyJKJ5iBs8lI9mbn0N9I9qR24Rlt3ai/51MHAbnAZMe52mhEO/spe6fIRGgWh2cKN0hc1djY/O0vGA8K5fpPh/MCCuZ458YwigLvYIVfVgrVV4zAhYzwAqp7pt7a5sa9Xl+JwPw6abkLVXu67On2Cpw56uGbH0LdT7IoMIG4xXQiHIeFh8sj2Y0Cqij7gwV3kuzhwOm39fITH+VhfM95MNq8LjqQRmDRyVqU7Brx9Agsi1fobQXCWe30Bcg4Nk7WvKat3xoylTzHmN/GtIZej/1Uxoe96NZdpHe3B8NL51lTc2IUN1InraROO+xdL19B5ujgUaz5Deg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com (2603:1096:400:1f7::12)
 by TYZPR06MB3904.apcprd06.prod.outlook.com (2603:1096:400:4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Sat, 21 Oct
 2023 12:10:29 +0000
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::a74e:15a:8561:9b74]) by TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::a74e:15a:8561:9b74%3]) with mapi id 15.20.6907.025; Sat, 21 Oct 2023
 12:10:28 +0000
From:   zhangxirui <xirui.zhang@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, zhangxirui <xirui.zhang@vivo.com>
Subject: [PATCH] f2fs: use inode_lock_shared instead of inode_lock in f2fs_seek_block()
Date:   Sat, 21 Oct 2023 06:19:07 -0600
Message-Id: <20231021121907.2908801-1-xirui.zhang@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To TYZPR06MB5178.apcprd06.prod.outlook.com
 (2603:1096:400:1f7::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5178:EE_|TYZPR06MB3904:EE_
X-MS-Office365-Filtering-Correlation-Id: b271fd51-a277-470c-dc81-08dbd22eb65f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H9jNJm+GcB/N2tAvU8ElxZcOxqNgYU99jiw3h0ol865B05SnV0z9vjethUV90zD/RzXl+kCa464gMRh6qnPB0FyQleBrc0ZfN7rDQ5i1E/FGvt6E0myrL8/zG61Td+PTTfgXsZdPTlIKZw18xpVoWAhLrJo/To/iQkDGDvFfXZWggP3koMP1wTYMmstzoV9ATsYNIPPyOIL2MQfDJjCdQntO4sJOekhRjyGJJStKzkoyTWGAysya/kSoscb8idrTp8PjhCc1h0WLBdtiQrJC/4+d864HK98it0rxbTCHfYUsJtXTEegGnLvx57CyfV7FnJslVHNprxHEMuqaCk8dCjmnzqEoF8BnunvYqe3JBoEqC2NA8Ar5z1wIxt/a2zWVhv/A8hom0Em+jVLCYkJsen4Q5z46Ufvnr8G6qwSIe0WldYnoe5Drgc+Oo8bd5dgkaA7o+hoBs4AwAVK8OtRbiyfcyTjbMFCFa7qQ6Dyf1zd0Iw0NgMOX7JmW1IN9yzmhmhrJ6pkylywoKiAkNb+3hM4QmdiaQRg0RJ9UXdWi4I5xJXtlOELCr75XT2zXkq+A0Fw2C/XUjyRDUUUAexEOVtPRJYm1v4lglQwsStcrMI21N86Zl6mUVBd6XXnswwCfb0kxOSykfxNTsyRrgTjV0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5178.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(107886003)(52116002)(6512007)(26005)(1076003)(478600001)(6506007)(6666004)(83380400001)(2906002)(66556008)(5660300002)(41300700001)(66476007)(66946007)(8936002)(4326008)(8676002)(316002)(2616005)(6486002)(38100700002)(86362001)(36756003)(38350700005)(43062005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r+MhNTjEd+54V4OLsGtApvKbVB+imX4AsQHgy5uywhHpskJSC1mMozcEWCGI?=
 =?us-ascii?Q?51e62HF+SD6nzU4Ugju7bAS8aZ+B66gvMrMgkf50IRC/wW8ceYXkUJYuLDu3?=
 =?us-ascii?Q?VjAfnN8KLYio/WrlZCjxvZF9yZPSKugUfq5cJ82oeq37SxNZZ+bu5ovsT//V?=
 =?us-ascii?Q?8qiaC9+TH7b3BW9i8csg8+BnF6QqKjAZGW2n+8kUPgDu9AOwbgH+iTEGVy+u?=
 =?us-ascii?Q?mHv3y/ZMtBG2JuYWUlICVIO62ePqFHqQRYW7pbBLATKKOx5QYTYTjyBRs+wP?=
 =?us-ascii?Q?A4euts6v6OrshnWXOFRwu9JXF+rjT7gKV+ialD9SPpFXUNKSkVYV4b0A3E+J?=
 =?us-ascii?Q?H/WhlqRgA/zeUinML4El/nmDZzx54Cb/n4i2LkdWy2IyAoE5m0yTIUYa3nVH?=
 =?us-ascii?Q?0C3Wj7vN6lAficsMpc7+CTdjErYhua2lKC/tx/mP5W6uiudC05JolOKT9piB?=
 =?us-ascii?Q?A2Oj+VG1DlJ7Dda0sggqIfryXJcc0DeQhmXSIWN/9gmPkVYijans9wOX/e5t?=
 =?us-ascii?Q?gpjyp6+9dz0k7+tQ+YlR3GCxVNGKQsMk42zJtttixnQmfKdfdnYkspi1cdsD?=
 =?us-ascii?Q?90brBzwSPPrBhnuM9saChcN/7eCNr/G5NcZcnl1drrciyRjXU3g6K/bfpFAI?=
 =?us-ascii?Q?p9cM4S0Cgce4QmCZ2Ox7+my8+u0Rsfw9ThdmybPvvYYV3We2Oq4N0xEfqIhU?=
 =?us-ascii?Q?FqlMqWCfoMEp5BZNBPNNyEBAORq0vNjEJD5DpLDhQVeFFLCUkk3r205kJ9Y4?=
 =?us-ascii?Q?f5hOrOTOtwbLiO4VXfRZf8hPl+qrcclnEVAuppbY+Tvw2QC/t1pM8jrF2HJj?=
 =?us-ascii?Q?+AhGF460lyaqeNrJahqul4qxahzEsh0Ixx6IYRRc+KeYilJtBn3FfPAxM8dI?=
 =?us-ascii?Q?GE3xTa6CzKoCyFjBRH4DoF5+w/eh688tUjzrpOZTkGxxMsyRljUsUvChbJ5V?=
 =?us-ascii?Q?vuIdUo8ADAV2kOWQxAcRamk2c5pgWk8UAVKlHO9VT7RG1Jcddscw3LErY+uK?=
 =?us-ascii?Q?wojKwO+iLKR8g/YAMK0Zd2rbJwosT0C6KR5baI81ufe2QFPKHVHO7XKjwBiM?=
 =?us-ascii?Q?OGCx3RXXsHXrkiej/yHT9/a/5D2U1BPU23YikU2w2qXhzfIaxrj4G6wHGCzA?=
 =?us-ascii?Q?1WMqBsyZAVCCJ40atOSkwN17uTAA6ZRQ2ikAHZbBNahI9cDVlgWowyHxhG/R?=
 =?us-ascii?Q?nrGWqEZzRgGvidwRSSuivvhz6KsROM977fbKKrPY4opNZnm8d5Jj+cGVacCE?=
 =?us-ascii?Q?o+4DYzqmm/5LZDIhNpUyA2Xzz2WaoF88xHOLu3+Z5BzreD7wpi/Rln8sASxi?=
 =?us-ascii?Q?lCRnF9RKbfrm3WlUagNvgw6jNT6ZCx2lzZJBFPV9i5sdv70d6bwKQFAlcxr8?=
 =?us-ascii?Q?rXiDY6yOXbxX070N+oeu/0GnHd7c7jBlHuJSv4WfZW7goT+g/lTf5yD4efOc?=
 =?us-ascii?Q?pifY58gseC0nRsbCxDy7NT8dt59RXV2UOBYcJneJE69BHwqVSyiwY3f35IUi?=
 =?us-ascii?Q?wwcsDNmsOzDh9ZfIjBt4GpflsRjoVf9tOkMfKIi0MPb1MvQFhp4IxGLOjGuw?=
 =?us-ascii?Q?wFXxRQMwAjpkZxKfAGrPiAdxJANwLZkGFspGePyp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b271fd51-a277-470c-dc81-08dbd22eb65f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5178.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 12:10:28.1623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNz4m3yByNDR+GPXx9Re96T0CqPvpvgljMnPYpXH+lMOzzf4VbjLnn08hSxuleS+tkpDQ8nzYxDW3C6QyhAxzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3904
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inode_lock_shared() -> down_read(&inode->i_rwsem)
       inode_lock() -> down_write(&inode->i_rwsem)

Inode is not updated in f2fs_seek_block(), so there is no need
to hold write lock, use read lock for more efficiency.

Signed-off-by: zhangxirui <xirui.zhang@vivo.com>
---
 fs/f2fs/file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 304d0516d3a4..d600ff48914f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -418,7 +418,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t=
 offset, int whence)
        loff_t isize;
        int err =3D 0;

-       inode_lock(inode);
+       inode_lock_shared(inode);

        isize =3D i_size_read(inode);
        if (offset >=3D isize)
@@ -483,10 +483,10 @@ static loff_t f2fs_seek_block(struct file *file, loff=
_t offset, int whence)
 found:
        if (whence =3D=3D SEEK_HOLE && data_ofs > isize)
                data_ofs =3D isize;
-       inode_unlock(inode);
+       inode_unlock_shared(inode);
        return vfs_setpos(file, data_ofs, maxbytes);
 fail:
-       inode_unlock(inode);
+       inode_unlock_shared(inode);
        return -ENXIO;
 }

--
2.39.0


________________________________
=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=86=85=E5=
=AE=B9=E5=8F=AF=E8=83=BD=E5=90=AB=E6=9C=89=E6=9C=BA=E5=AF=86=E5=92=8C/=E6=
=88=96=E9=9A=90=E7=A7=81=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E4=BE=9B=E6=8C=
=87=E5=AE=9A=E4=B8=AA=E4=BA=BA=E6=88=96=E6=9C=BA=E6=9E=84=E4=BD=BF=E7=94=A8=
=E3=80=82=E8=8B=A5=E6=82=A8=E9=9D=9E=E5=8F=91=E4=BB=B6=E4=BA=BA=E6=8C=87=E5=
=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=E6=88=96=E5=85=B6=E4=BB=A3=E7=90=86=E4=BA=
=BA=EF=BC=8C=E8=AF=B7=E5=8B=BF=E4=BD=BF=E7=94=A8=E3=80=81=E4=BC=A0=E6=92=AD=
=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=96=E5=AD=98=E5=82=A8=E6=AD=A4=E9=82=AE=E4=
=BB=B6=E4=B9=8B=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=E6=88=96=E5=85=B6=E9=99=
=84=E4=BB=B6=E3=80=82=E5=A6=82=E6=82=A8=E8=AF=AF=E6=94=B6=E6=9C=AC=E9=82=AE=
=E4=BB=B6=EF=BC=8C=E8=AF=B7=E5=8D=B3=E4=BB=A5=E5=9B=9E=E5=A4=8D=E6=88=96=E7=
=94=B5=E8=AF=9D=E6=96=B9=E5=BC=8F=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=
=BA=EF=BC=8C=E5=B9=B6=E5=B0=86=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6=E3=80=81=
=E9=99=84=E4=BB=B6=E5=8F=8A=E5=85=B6=E6=89=80=E6=9C=89=E5=A4=8D=E6=9C=AC=E5=
=88=A0=E9=99=A4=E3=80=82=E8=B0=A2=E8=B0=A2=E3=80=82
The contents of this message and any attachments may contain confidential a=
nd/or privileged information and are intended exclusively for the addressee=
(s). If you are not the intended recipient of this message or their agent, =
please note that any use, dissemination, copying, or storage of this messag=
e or its attachments is not allowed. If you receive this message in error, =
please notify the sender by reply the message or phone and delete this mess=
age, any attachments and any copies immediately.
Thank you
