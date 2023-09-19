Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7124A7A6083
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjISLDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjISLC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:02:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8012E3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juSfX+c1ZULHoRR6SU6/x7kXfReQ/DwTo86K84GZ4qsE7BOt8HjP8vHj43lluu5vtRn2YbAJGaTNeFs3HwJAYDHCF2XPDvEy3KaKJL9EuoAceatd8ZfFsDzmhosGpH5LuaUXNxNx5P2fjivkkb2kKFZWP6kveIhHjytygbUUq7kHeyHRRt71muGxkqSx7SlbChSL25nnbDIBSa+/3WNU7W3h8oSmMx0IVbInOsFB456xhEgeapv8SHY0ovgM+qB8EoLR1Lg7/AguDFxnaNS085J6p9nvOAs2xqdGE73tA3CFGRrKT+ylXl+eXSVzi7QJC/kahcEKD2ZRAv2CDOHLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/Zsd+jyqGF+pCVofqpJHSWhT4mE3So0GY+NEgTTrns=;
 b=CA1hGQ1dtvBO2X7+J3oCA0iW393scOQjne/WtKTluHubKlT2Ln3prr9dOQdmJLw3kWq4yzWXYfIW98RQgcKMhH56pv7gI9RkCILoTtlo5JCi3TsyIl3X20R1XI1c75elJ63RYprbGG2gTAQZAwCgXp7Q4oXM169j8OC3n03mGWRnHlTXBga+VebL1zohKqKxN5B5SEbpLsMoj/8IOsoxNl371/RXZ1OBMUd9yXNEHCyYSEgWFPMukzO0aV7vRK+j4WyvXp9xpvqq7wqMP8/iiVtJNXDwYlnLtpcPHUNlN/2MkyMuRpEODbjxX8+4I9fKol1vWf4TZFODNtFrNZh0Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/Zsd+jyqGF+pCVofqpJHSWhT4mE3So0GY+NEgTTrns=;
 b=od+CrD5Dk5eO141urMhmLvzVF36nc1j9Gb+u5nn8yQClil2bXFtTjiWpjcihF7nU7Md63r1YkWo64kbQ1dafdW7A2S0R45KMB9EIY1c9rzeAg9ocuVeLhG65kH8T5Wmh0fpcazznNG1GrkKoCZJ9J9wsD29P3UeWFS+ufEr7bTw=
Received: from MW4PR04CA0328.namprd04.prod.outlook.com (2603:10b6:303:82::33)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 11:02:48 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:82:cafe::80) by MW4PR04CA0328.outlook.office365.com
 (2603:10b6:303:82::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Tue, 19 Sep 2023 11:02:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.0 via Frontend Transport; Tue, 19 Sep 2023 11:02:48 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 06:02:41 -0500
From:   Jiqian Chen <Jiqian.Chen@amd.com>
To:     Gerd Hoffmann <kraxel@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        David Airlie <airlied@redhat.com>,
        "Gurchetan Singh" <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
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
Subject: [QEMU PATCH v5 0/1] add freeze_mode for virtio-pci and support S3 for virtgpu
Date:   Tue, 19 Sep 2023 19:02:23 +0800
Message-ID: <20230919110225.2282914-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb9a496-d6f2-4a8f-3f1c-08dbb8fff5f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CaNwgHHlfb3/y/LgmfU4qVQaPChDDTxN7sWlWTHyAEsVpq9e3kK5j6OYWTyxQ4lzLxQEsW1HFfHdjj61sgOXtXmoA6R8Z2syomitcrs4QS9qiYLOEgO7a4wOrUZSwFMPTnhgLjGBbUBbVmGNDu18jtiod88mcr/ZNqozeb6bKJpTKJNN8Z+N8ca5WKTspTDSU+f7LxHPsS4kGRz+q10h8Xi9XbTs/Ts49P60bVhVz2lzg6jbeehzmKZIAgOm+0Yu/JyMVSZCq40nxTfqzArOYqx4/XUmN9vRK74kaFOo0nV+ojUjSvRs88HkVXA3tUZjf8OE1/hIWJ9pKUqIHVglfA44mh4Ez65birgJp0N+8/VTV6fzwI9MHsHsUG6Qf+9+Hy03jz5s6ioHvLZN0c4IMWTTnuQDXnjEsrhHtsEUkp3Y1VXVzkDuYenSrkeFRBwN4Qgs5+FMRBed79CJs4lRwydiv9d72mE7kHS4hwORJHaFaWhbhHMMNM/ML8i3YGuNBOkdz//QX00NaTC7XPt6H2gXIO/HgVyrDqfAUNHcC0Te7CoV+vMjBqP6wYFti32U12jzlr4cRD5VCHh9DdXdWem3+ozNKv9JjI6YhqpckNjFp1hbm5l17YpXiqot/eqWihkBXSP2FcpLs3VPZqmc9kMZNaamvYCxoeDOiDbtJtPvvp/v6znaajHJ8qrhqqX8u+jRDj74R3/G9HSYAgRsb4LZ34CzFRbyKH4p+tIBC9c9cUYBilTHErRuG89p8Bqidq/ij1IzDcQR+g6pIxQLDcT+av+Z94DUNFPzSl5n51SKlfUfEjEFGOkouoiFkKR4ziawO7llpZtlI9F0RYHqrPklXbUJ5v6wgT4EntxpeE5rinnS2OGg3VoZFea1uon6
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(1800799009)(186009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(478600001)(7696005)(6666004)(40460700003)(86362001)(36756003)(81166007)(921005)(356005)(82740400003)(40480700001)(36860700001)(2616005)(1076003)(16526019)(26005)(2906002)(47076005)(336012)(426003)(966005)(83380400001)(8676002)(5660300002)(110136005)(8936002)(4326008)(41300700001)(7416002)(70586007)(70206006)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 11:02:48.4156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb9a496-d6f2-4a8f-3f1c-08dbb8fff5f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360
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
This is the v5 of Qemu patches and v5 makes below changes:
* Since this series patches add a new mechanism that let virtgpu and Qemu can negotiate
  their reset behavior, and other guys hope me can improve this mechanism to virtio pci
  level, so that other virtio devices can also benefit from it. So instead of adding
  new feature flag VIRTIO_GPU_F_FREEZE_S3 only serves for virtgpu, v5 add a new parameter
  named freeze_mode to struct VirtIODevice, when guest begin suspending, set freeze_mode
  to VIRTIO_PCI_FREEZE_MODE_FREEZE_S3, and then all virtio devices can get this status,
  and notice that guest is suspending, then they can change their reset behavior . See
  the new commit "virtio-pci: Add freeze_mode case for virtio pci"
* The second commit is just for virtgpu, when freeze_mode is VIRTIO_PCI_FREEZE_MODE_FREEZE_S3,
  prevent Qemu destroying render resources, so that the display can come back after resuming.

V5 of kernel patch:
https://lore.kernel.org/lkml/20230919104607.2282248-1-Jiqian.Chen@amd.com/T/#t

The link to trace this issue:
https://gitlab.com/qemu-project/qemu/-/issues/1860

Best regards,
Jiqian Chen

v4:
Hi all,
Thanks for Gerd Hoffmann's advice. V4 makes below changes:
* Use enum for freeze mode, so this can be extended with more
  modes in the future.
* Rename functions and paratemers with "_S3" postfix.
And no functional changes.
Link:
https://lore.kernel.org/qemu-devel/20230720120816.8751-1-Jiqian.Chen@amd.com/
No v4 patch on kernel side.


v3:
Hi all,
Thanks for Michael S. Tsirkin's advice. V3 makes below changes:
* Remove changes in file include/standard-headers/linux/virtio_gpu.h
  I am not supposed to edit this file and it will be imported after
  the patches of linux kernel was merged.
Link:
https://lore.kernel.org/qemu-devel/20230719074726.1613088-1-Jiqian.Chen@amd.com/T/#t
V3 of kernel patch:
https://lore.kernel.org/lkml/20230720115805.8206-1-Jiqian.Chen@amd.com/T/#t


v2:
makes below changes:
* Change VIRTIO_CPU_CMD_STATUS_FREEZING to 0x0400 (<0x1000)
* Add virtio_gpu_device_unrealize to destroy resources to solve
  potential memory leak problem. This also needs hot-plug support.
* Add a new feature flag VIRTIO_GPU_F_FREEZING, so that guest and
  host can negotiate whenever freezing is supported or not.
Link:
https://lore.kernel.org/qemu-devel/20230630070016.841459-1-Jiqian.Chen@amd.com/T/#t
V2 of kernel patch:
https://lore.kernel.org/lkml/20230630073448.842767-1-Jiqian.Chen@amd.com/T/#t


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

And now, display can come back and applications can continue their status after guest
resumes.
Link:
https://lore.kernel.org/qemu-devel/20230608025655.1674357-1-Jiqian.Chen@amd.com/
V1 of kernel patch:
https://lore.kernel.org/lkml/20230608063857.1677973-1-Jiqian.Chen@amd.com/


Jiqian Chen (2):
  virtio-pci: Add freeze_mode case for virtio pci
  virtgpu: do not destroy resources when guest does S3

 hw/display/virtio-gpu-gl.c |  9 ++++++++-
 hw/display/virtio-gpu.c    | 12 ++++++++++--
 hw/virtio/virtio-pci.c     |  5 +++++
 hw/virtio/virtio.c         |  1 +
 include/hw/virtio/virtio.h |  2 ++
 5 files changed, 26 insertions(+), 3 deletions(-)

-- 
2.34.1

