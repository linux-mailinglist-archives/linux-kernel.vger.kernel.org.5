Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BB379B7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343544AbjIKVLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbjIKKbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:31:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F997CD2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCOUqC9+7KumM8l1zTYwaAdPFnRlgEDjraZnOIQ/oCy5Gp5DW0SYOrKqYwQW24AnG++1rT0yicxJ/27afPDKsB4CsImBlmQhQrgVqoNuxrT4iNwSi4q84A8OsaQHBBvmASLeynWwENfaSRknU8/tFG7mVc4xwrcMIRtLiB8FQYhauTy/CDdibyOWa2kM9UADMJZ0kRuXIfcnA9TAN12CjBHkYvODRMCqEn17HnrFRKylRvBxL/36I0dszkoj6w+tjPrZe8RAQisR3t5+9zcV2b7MhQTOJpEBBQ+OTGhyX5N+tR7BDtL2mdKOJI9CgcD4BBCcgLJOKAGJzShbk8imew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cT71/eXo6AlUAJh47DKE/DCoHPi2W4uf+wVLjG6ycOQ=;
 b=Rjm/szqw9TrCsK7DF5lwxPwte+Fj0XtfzAgv5snWKKMDdNHq1YU8cEc5AAhTn3oZtEr8PzoLm85bTHVtt1PWfXgaZaJB3Fbte5X4aHHVT7wubu+UVezqoYi6V/+ONyCT5PQsEP/OQzBpJp6MRkkWHokYymLCgHHV6QJn0XpbQl88yUpglRJBQKaJxKafzOOZzyVokJlPqyGgHq2jm2JOd6kTqUSKFzD11yFph6a9NNMXjdEOr2w/YNR69SvT5FPzxJrXsBiurlVMt9jkGeRh62bUYuXzXw/aXJR8jNS3w0QE1hu2dQZPu7FkcKKynyn2lbbL5O5XBJQP+2RrG9W9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cT71/eXo6AlUAJh47DKE/DCoHPi2W4uf+wVLjG6ycOQ=;
 b=36hZVfxCqpSFOFwRXOPJzhtpT2+O/qtj5LjPq1hSLakTLQ40F38rTVJQAVJ8APdcT3pAa1iEWLD142XX7eVCW4jhEZv/vXjN/S47pKElln+YTm13apbb0DZiRDfs2v+qayaPtSXuzNe6tOrsiXFDlWhAEzYzNTTuhtHRXaWUXM8=
Received: from CH0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:610:b3::20)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 10:30:56 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::10) by CH0PR03CA0045.outlook.office365.com
 (2603:10b6:610:b3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 10:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Mon, 11 Sep 2023 10:30:55 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 05:30:51 -0500
From:   Jiqian Chen <Jiqian.Chen@amd.com>
To:     Gerd Hoffmann <kraxel@redhat.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Robert Beckett" <bob.beckett@collabora.com>,
        <qemu-devel@nongnu.org>
CC:     <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Anthony PERARD <anthony.perard@citrix.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        Honglei Huang <Honglei1.Huang@amd.com>,
        Julia Zhang <Julia.Zhang@amd.com>,
        Huang Rui <Ray.Huang@amd.com>,
        Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [RESEND QEMU PATCH v4 0/1] S3 support
Date:   Mon, 11 Sep 2023 18:30:30 +0800
Message-ID: <20230911103031.1432693-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: 0954440d-04eb-4e5d-15fa-08dbb2b22ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z1QWmE0yC0v80ESFXN/LPjCqnyAMMgnFAQJ68h9ScGOVXAVzEnACWByy8UCqB90S0nrTABlZsx2Jj/m/gT+qQsqeLjtGDU1lvjvevdlZjfngxts5DcjbslInARCGMkT9WFe6yowhrnMgryud3T+lRyscbEFrCp4GrVSdM2rDWFh9eEhKFHT0gbAwAzIlH/tS6X0du9DNAJ8lsstQEcqqXMsKgrlkK9HfsHPiv4zqQXbXCwVKpZxjeBz4/85wP2pwDe89wq8h15fwg9+V/OvJuybz4XV8okat8ZSWd3K5irBT1f+viKp3y0qq9CCSle4fjxrNeRznPps7u3ImMbHRWnL/Ni1NafeOPWNvB4VwcmtkcVsycUF9Sc7+OcCwQ+uIWtfYkwe8w918tqRhA63aunXdJsC4y0k8OoTQqy2ffER/phgxQw0/F98k1wambWqi1kmAJypb6GkSx/4gPbeg/v3x/j81UICIZyrFJZyfRouvlkDac5gcXfOf8/XhwLRezOys1KUS1eD1tx8UhdVYJuO6SrQ4DfEYI9eqfpcnts7kIJ6NoAHRJ35duSI2OllBmZviSPjoWmyjNInfcEHYwbF+UU/+AnrLGJXuRka6xcM3WV25IEHVj60+3nGIgKRmLhZfy739SFGzImFlNTCx+9CpAxj9ledZEASR9sPg09Jli3YE2LKZpgcnh9WQ4mGgioq7k7wjypz+82NHmbqZSfHk9nbC13oLGL9AuyQDpBp4dHI1e4pan3pNfZkOkSKXYr8GjR8ArSIn0jtiYtG7TpzDfiwWDDpf6CVfqmwmRmo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(186009)(82310400011)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(356005)(6666004)(7696005)(83380400001)(966005)(41300700001)(478600001)(336012)(16526019)(2616005)(426003)(7416002)(70586007)(2906002)(54906003)(70206006)(8676002)(316002)(26005)(5660300002)(110136005)(8936002)(1076003)(40460700003)(82740400003)(40480700001)(86362001)(4326008)(36860700001)(47076005)(36756003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 10:30:55.9137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0954440d-04eb-4e5d-15fa-08dbb2b22ead
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I hope you’ll forgive me if this disturb you. Since it has been almost two
months since the latest patch was sent out, I didn't receive any reply, so I
rebase the latest master branch and sent it again. I am looking forward to
getting your response.

Best regards,
Jiqian Chen

v4:
Hi all,
Thanks for Gerd Hoffmann's advice. V4 makes below changes:
* Use enum for freeze mode, so this can be extended with more
  modes in the future.
* Rename functions and paratemers with "_S3" postfix.
And no functional changes.

latest version on kernel side:
https://lore.kernel.org/lkml/20230720115805.8206-1-Jiqian.Chen@amd.com/T/#t


v3:
Hi all,
Thanks for Michael S. Tsirkin's advice. V3 makes below changes:
* Remove changes in file include/standard-headers/linux/virtio_gpu.h
  I am not supposed to edit this file and it will be imported after
  the patches of linux kernel was merged.

Link:
https://lore.kernel.org/qemu-devel/20230719074726.1613088-1-Jiqian.Chen@amd.com/T/#t


v2:
Hi all,
Thanks to Marc-André Lureau, Robert Beckett and Gerd Hoffmann for their advice and
guidance. V2 makes below changes:

* Change VIRTIO_CPU_CMD_STATUS_FREEZING to 0x0400 (<0x1000)
* Add virtio_gpu_device_unrealize to destroy resources to solve
  potential memory leak problem. This also needs hot-plug support.
* Add a new feature flag VIRTIO_GPU_F_FREEZING, so that guest and
  host can negotiate whenever freezing is supported or not.

Link:
https://lore.kernel.org/qemu-devel/20230630070016.841459-1-Jiqian.Chen@amd.com/T/#t


v1:
Hi all,
I am working to implement virtgpu S3 function on Xen.

Currently on Xen, if we start a guest who enables virtgpu, and then run "echo mem >
/sys/power/state" to suspend guest. And run "sudo xl trigger <guest id> s3resume" to
resume guest. We can find that the guest kernel comes back, but the display doesn't.
It just shown a black screen.

Through reading codes, I founded that when guest was during suspending, it called
into Qemu to call virtio_gpu_gl_reset. In virtio_gpu_gl_reset, it destroyed all
resources and reset renderer. This made the display gone after guest resumed.

I think we should keep resources or prevent they being destroyed when guest is
suspending. So, I add a new status named freezing to virtgpu, and add a new ctrl
message VIRTIO_GPU_CMD_STATUS_FREEZING to get notification from guest. If freezing
is set to true, and then Qemu will realize that guest is suspending, it will not
destroy resources and will not reset renderer. If freezing is set to false, Qemu
will do its origin actions, and has no other impaction.

And now, display can come back and applications can continue their status after
guest resumes.

Link:
https://lore.kernel.org/qemu-devel/20230608025655.1674357-1-Jiqian.Chen@amd.com/

Jiqian Chen (1):
  virtgpu: do not destroy resources when guest suspend

 hw/display/virtio-gpu-base.c   |  3 +++
 hw/display/virtio-gpu-gl.c     | 10 ++++++-
 hw/display/virtio-gpu-virgl.c  |  7 +++++
 hw/display/virtio-gpu.c        | 48 ++++++++++++++++++++++++++++++++--
 hw/virtio/virtio-qmp.c         |  3 +++
 include/hw/virtio/virtio-gpu.h |  6 +++++
 6 files changed, 74 insertions(+), 3 deletions(-)

-- 
2.34.1

