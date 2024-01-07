Return-Path: <linux-kernel+bounces-19023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 805558266DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235BC281617
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 00:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D27A5B;
	Mon,  8 Jan 2024 00:30:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2056.outbound.protection.partner.outlook.cn [139.219.146.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB8A42;
	Mon,  8 Jan 2024 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdW86ByBO/wPWADvlmvUYMosSXBZTJf6R4TAKjv+YKUC71RbPeln4mOpKmwEO3ypNKSN+rpLjNWA2qxREqUFB8jCF7LmLLKYNBSChXLlxc+ROBMRzkKEgQzvNqZ4JIEpg6Yos274pwvVG6e4bT6KtKRMCAtp0kw1SrSg5NUt5NiWBxwyKsYNOs2vvzdGoQLrxWeYFJGeKKunxXuAFymPWnyYOsU+kYEgNLd6txSs83i1LFycp+HxZbHfS2J1F/x79IhpUUEdpJRfnFQSOSX0v+WZmfMsv/uhy+npHCd2u/IUrmtsNZeqw1L2CRnOH/G0MuDHvx+/b2dPNqtAXDvyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+vrQFgSoKTZO2A5Rdzo/XRCDPP2BiuuJUSfRaHALPE=;
 b=mRChNppbO8JFWRJYXOS9FiEJXcdylBAa2DZlez6DB+NiYUIQeRp83iSLUxz6/LXDVAAkb5j3GyBEjuB64P0HEa+tmG+xBKu+yV7TgKRbvs1i+HLAPYoXdhXb/Aby/RNjuDqSFYoZNa8cWc1oE4/N3epBtOKZmbXovLjhoCcWQV3/drgLYQfSExrA9qEYOoMA8ME5SStOPW2OPwNFYmv7xwivugXHog+MxyzmtbtykNzUvI4/LXw9f10tm/iRHotB6LXSjkhnPUwlnElNHgY7JvQtghO5fki9bZD2IFDwE+E0st66FLWsP3oYSJA1Fm8UJ7H+2mKt+FIAQ1B7Pg8ddA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6) by ZQ0PR01MB1032.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Sun, 7 Jan
 2024 23:57:37 +0000
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::1dbb:b090:7d89:4e22]) by
 ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn ([fe80::1dbb:b090:7d89:4e22%4])
 with mapi id 15.20.7135.032; Sun, 7 Jan 2024 23:57:37 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 RESEND 0/3] StarFive's StarLink PMU Support
Date: Mon,  8 Jan 2024 07:56:54 +0800
Message-ID: <20240107235657.2372910-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::9) To ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1160:EE_|ZQ0PR01MB1032:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be37f59-d6ad-48d9-b6d3-08dc0fdc6ce8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SjFmBKYbvL96+cLVcihqLlLUsL2yQWF0uupnOMf/gYM1OoINnHUD8uO0ckpZbKUbHgCgBWuummi7+taAQZGJH9A8oMf9Ks3IsD80vJJ2/NgySvEK6Ckme31sKGILBPx3aBosGVXJ4HAijZdEypnvAKtUdsuFGqZ6LM/YTwgoXzJx33aVW6KtXtWgqnZg/7XlK/vilwcR6I8vtQMcHdtkA2cQ6hS75w7ANQlX2Ho0m7egnC82CxMM6pd1ypvQZisVVzRypWBExd6P/vXonDAR+x9hky/hJttMN/9W1+xEFvIVsjPUr+9/3JpNOWvgqSuk9NxOGBFt1VpVALWApK0Kbg5jlfDLW1vE0FbK6bcNKY6Zzh2lH70q+d12sbmPOsm7etsGHNpti5aiZ5lJLgjfwieO2mgB62bBop3wLism8QHn5s3YgfPAUR8Zm5UIWllFy4xtQ7Vz8JW9sTjivBFXrplqtvO41aIBFfr7enWQC9mFcYPJuddIMRWlPY50pZwFCC6mRTCTAhz+D3gBdKuzGcg8urAv7ewhk2K3bryyqzwz1ayTSDAh1Tbndl70S6E/zzIe4D7wnOz1gdnuyX2w7C2DsXHaXPVlXDRz8XjYZHEQ72Noadmdm9+vRZDSNwZ7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39830400003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(36756003)(38100700002)(921011)(38350700005)(86362001)(83380400001)(508600001)(41320700001)(8676002)(4326008)(1076003)(66946007)(66556008)(40180700001)(110136005)(2616005)(26005)(8936002)(40160700002)(54906003)(52116002)(6666004)(66476007)(7416002)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2nALaVY4sj4oWb0xg+wu0lBEhGYX2aIkhh8Azc14EhhkML+Sto34AhRza1PE?=
 =?us-ascii?Q?dqm6i75qb3iN15BhAlYi6TvDeQfsIJDfOA7VRzZJz90kqq+wF4Jxyk6olieJ?=
 =?us-ascii?Q?20QhytDmUQ/odtdxZrKtl2x23qBV3p4uvdbM/aITwoMsMQUMcDfx6pzrg5ou?=
 =?us-ascii?Q?j0Rya0KcK+e1ph4z76H7F2Vd5RV45PLPovvRptVKv7xMJAwGVmeT86Z2cKQj?=
 =?us-ascii?Q?i/gy7Q9gaPgi2sVfbRNTQx1hJ8N9l/eueQ6KqB+4H90UoG7syQmDDfegIuL5?=
 =?us-ascii?Q?FvKmfbmJu6mlNe1ysN76A5B6IvtcZaX49/kExCHL7Nz9gbAzzv4UN8Lr1C7G?=
 =?us-ascii?Q?5CWiKIquXIsporfc1H36+hBKf4IriGexoirVwMviMSEM49lTGkTotMFTfNNr?=
 =?us-ascii?Q?h02iBR5kYVC4sdMEB8j80ewAH0Apg/HGXz1fS+SUhOqQv1vsdjACWIflH7R4?=
 =?us-ascii?Q?DVy8/1MhCBdr4U+N6tCn1z/4MkG2j3QTzxZ+nKBeTfsKRxOatMnaxMBEf3TC?=
 =?us-ascii?Q?dOPz/3iVz/adOufVqECfQaoHv/EwK9Qh0mwzKvnHuSe6wz4bPmD4eYWUZXHK?=
 =?us-ascii?Q?4BQ5ThUY/7jLNCfTACpP59w2g7NPrjBYjql2aWR0U3hUJQ9lZQTho+POlISS?=
 =?us-ascii?Q?fy2VFmqyhFIsc4+5aoapG4AOe0gQq3Ru8vPiHo1KYPZ/dKhcvAGHisVWidi3?=
 =?us-ascii?Q?bEZ5MA0aptutCEC5DZxvyGxeBLrKVj6P51pPNYTPg0UdBFSZCCW5NJ3wS0VO?=
 =?us-ascii?Q?jZLEwCdMbaNQWkJ25aQ7ympGKvps40d20+JHzYv8YxBDi7ugVrrbT/1GJJD1?=
 =?us-ascii?Q?/tZOYZ9ng31AVP3onbgnGRRb1ejG9/4I5mvqA2Uj5CpSp2FX2HauCP+N06U6?=
 =?us-ascii?Q?qtMbUxSdpuUTAGAxY5PR8h5xJRFBhhXnvj347KISEdLEjeDb4lZkz+cv74X7?=
 =?us-ascii?Q?vGO56oaq7ic7UvXgKKJ5gz1A233LPF+eX7z802OjJgnBIE/D/uTu7E0nLAD1?=
 =?us-ascii?Q?GlfQqHEj6NTePNkZHGJQ+5ET0P5oac0Nc0oHAbFeQVNZspZfcfWmRQStwNdI?=
 =?us-ascii?Q?grzdU8oysRvaWAVxosNBi0qxj2I3cEjCkQCiDUTTNJWhSIGvMi5bbUbpoNvp?=
 =?us-ascii?Q?3wLazZJJjhHm0/lLKK5/TeG1nvXAl1bNDmL9NL8v9xV1xAdwvzE6piHW9ep5?=
 =?us-ascii?Q?6gjrmWUNplMqkuxmtWhy4r7jnbU0mkM5l667LjJCDroJUe3y6pps3uhUD3ym?=
 =?us-ascii?Q?IxPftemJ0KFMrTZEZ0YPey7TPOK/rFs/Hze/liOthYWPOHxJbhklKxtcVQ51?=
 =?us-ascii?Q?BQGEmUO67fp7wfmSaIbC3xIftDxCtZuaKMefNe0CNdWkKYVTQdiBb0DQbZJE?=
 =?us-ascii?Q?5jmKdQRcrSyN1xphK40lg1gwpFP9WO1GkloyJatfIp3x4dQHPT8wNjFXcAxN?=
 =?us-ascii?Q?TdyptHXR1Dy+nymnuZBqzfjlz+XAcVa2CnTPwq/ZKXrCiGoKkgGQ9+Je0POA?=
 =?us-ascii?Q?7KpKIEaz6vQp+baw1RLDQXKTZCluZ71+oS9MiX70a3XWrkpTRqBkB9IYywP8?=
 =?us-ascii?Q?M0DnAWBTxzjaNKzoGlTPHcV2+pWrtIzHB4MmpR0mIRam+s5P+ncHXVxX6+aE?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be37f59-d6ad-48d9-b6d3-08dc0fdc6ce8
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2024 23:57:37.6310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHxguTKNS9tbAsP20eYpMscySQRTlJU9x0O0FDZawZx4D+e9KWvDEtP08LSEuQLgBelezkvKyNx7bZjeEv+nno8nven3KutdFwC6TTxx1Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1032

Changes since v4:
- Add Reviewed-by tag from Conor to dt-bindings.
- Add Documentation/admin-guide/perf/starfive_starlink_pmu.rst.
- Rework starfive_starlink_pmu.c based on Jonathan's comment.

Changes since v3:
- Change dt-bindings filename along with the compatible field to
   "starfive,jh8100-starlink-pmu" with SOC specific naming
   convention.
- Drop unused label defined in examples section in dt-bindings.
- Update compatible field in starfive_starlink_pmu.c to the
  aforementioned.

Changes since v2:
- Change compatible field from generic "starfive,starlink-pmu"
   to "starfive,starlink-500-pmu" with specific IP versioning
   in bindings and driver.
- Fix warning '-Wmissing-prototypes' reported by kernel test robot,
   by appending static to starlink_pmu_set_event_period() in
   starfive_starlink_pmu.c.

Changes since v1:
- Change 'depends on SOC_STARFIVE' to 'depends on ARCH_STARFIVE'
   in Kconfig

----

This patch series adds support for StarFive's Starlink Performance
Monitor Unit(PMU).
StarFive's StarLink PMU integrates one or more CPU cores with
a shared L3 memory system. The PMU supports overflow interrupt,
up to 16 programmable 64bit event counters, and an independent
64bit cycle counter.
StarLink PMU is accessed via MMIO.

Example Perf stat output:
[root@user]# perf stat -a -e /starfive_starlink_pmu/cycles/ \
        -e /starfive_starlink_pmu/read_miss/ \
        -e /starfive_starlink_pmu/read_hit/ \
        -e /starfive_starlink_pmu/release_request/  \
        -e /starfive_starlink_pmu/write_hit/ \
        -e /starfive_starlink_pmu/write_miss/ \
        -e /starfive_starlink_pmu/write_request/ \
        -e /starfive_starlink_pmu/writeback/ \
        -e /starfive_starlink_pmu/read_request/ \
        -- openssl speed rsa2048
Doing 2048 bits private rsa's for 10s: 5 2048 bits private RSA's in
2.84s
Doing 2048 bits public rsa's for 10s: 169 2048 bits public RSA's in
2.42s
version: 3.0.11
built on: Tue Sep 19 13:02:31 2023 UTC
options: bn(64,64)
CPUINFO: N/A
                  sign    verify    sign/s verify/s
rsa 2048 bits 0.568000s 0.014320s      1.8     69.8
/////////
 Performance counter stats for 'system wide':

         649991998      starfive_starlink_pmu/cycles/
           1009690      starfive_starlink_pmu/read_miss/
           1079750      starfive_starlink_pmu/read_hit/
           2089405      starfive_starlink_pmu/release_request/
               129      starfive_starlink_pmu/write_hit/
                70      starfive_starlink_pmu/write_miss/
               194      starfive_starlink_pmu/write_request/
            150080      starfive_starlink_pmu/writeback/
           2089423      starfive_starlink_pmu/read_request/

      27.062755678 seconds time elapsed

Ji Sheng Teoh (3):
  perf: starfive: Add StarLink PMU support
  dt-bindings: perf: starfive: Add JH8100 StarLink PMU
  docs: perf: Add description for StarFive's StarLink PMU

 Documentation/admin-guide/perf/index.rst      |   1 +
 .../perf/starfive_starlink_pmu.rst            |  46 ++
 .../perf/starfive,jh8100-starlink-pmu.yaml    |  46 ++
 drivers/perf/Kconfig                          |   9 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/starfive_starlink_pmu.c          | 643 ++++++++++++++++++
 6 files changed, 746 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/starfive_starlink_pmu.rst
 create mode 100644 Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml
 create mode 100644 drivers/perf/starfive_starlink_pmu.c

-- 
2.25.1


