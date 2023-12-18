Return-Path: <linux-kernel+bounces-3361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4689816B74
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1E11C22A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212BE17999;
	Mon, 18 Dec 2023 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qb+N0XGq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176C16408;
	Mon, 18 Dec 2023 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8iaJNy2hdG1PbaYThxsPMyrXZehAVvUNKdYPDSOxeM5O4miOgvA35vTXrL3yNvG3jzg21+68lbrmIOia79J1mBSTvo73AgXdVnEHrbBbdT1l4j/6sEnSyMdgnRymK3OT2/t5/AHlJkT/r/ENL6C7J7GyLVqWA9GS9byHM/HvYtmj0REA9e2BnxAptBNDx71B5uLeXGTvXHfIFK2BhRlx+VooqkD9n8eUC21jvlQPFERgjBERmHNJMVlPjJTkg+5PmtmWb1dEAqtCFCXXbgJf0HnfwNhqPpVZwtSoIi83vjs2HsNmwWwSpWo/C8wB4pOcfhpvaNYq8lyJxPUXXuHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6MMuppckFBoewfR2ux1DUxTv1PH7Z27IhLBDzZUVFs=;
 b=PxbeuuY34utwUKIkOFrnMHCLK0zaQAtWj9ohzqUBJ3UXqUwOau9QpCu4I3R2xxNqIZQALs1PFGsuoX5xS/DL91JgjmmTSCC7tbdtKpSHSjeyW04kcDmPlVNH97GhHIN3LMjd0ZMEjLSV8bOztCWEyZ5T4IjLM0OyASRNWS+te7FEvGAiFAECHh2Jx44sv0fEnbJ8NUa67cF/WsOt1sRH3ULhD5MzVjTLNI9uAo9ETK33hVQZOD+FsqgL+xKzjDayVqCp8Y1pdLs79qvmDkTshbpKMVOC6EF7SynMu9DMsyE/9POBqyk3RkvT+S9t94cVc5kF9kKFvNvTJVUtPL91dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6MMuppckFBoewfR2ux1DUxTv1PH7Z27IhLBDzZUVFs=;
 b=Qb+N0XGq7ALzdfmeonyM/yM/lBzX+yy/p08gnH8oBrDhUcc4FX+CvVCGXwp42Vn+mpHsdPedbqUom7SMgwlRH/5wMPzIkpAqrU8UVEmXZOHJ/sDNDHrXua/Jr7CZUr76AFl9cVrOwq8ndZYiSl5NOuULWeJozB0vdd8HOrShblaQ2gX9vihDNcCa6qlhnBfE0LCCxWp8l/Kx7yk4z3gF10ixdU7sx5cRKLdC8RJgt2gmcxQMHJLQ7TrnZCBSRDVgVa6woFLuoqs9g8/XD9y8LJ7NTps2a6jvyjYhwPQrwRZi59v9nBKsK5+XBzzASV3PDJWj7x1ZqsOsq5K2Fe2K2w==
Received: from MW4PR04CA0381.namprd04.prod.outlook.com (2603:10b6:303:81::26)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 10:46:17 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::28) by MW4PR04CA0381.outlook.office365.com
 (2603:10b6:303:81::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Mon, 18 Dec 2023 10:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 10:46:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Dec
 2023 02:46:08 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 18 Dec 2023 02:46:08 -0800
Received: from localhost.localdomain (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 18 Dec 2023 02:46:02 -0800
From: Kartik <kkartik@nvidia.com>
To: <thierry.reding@gmail.com>
CC: <akpm@linux-foundation.org>, <andy@kernel.org>, <arnd@arndb.de>,
	<christophe.jaillet@wanadoo.fr>, <frank.li@vivo.com>, <jonathanh@nvidia.com>,
	<keescook@chromium.org>, <kkartik@nvidia.com>, <linus.walleij@linaro.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-tegra@vger.kernel.org>,
	<pdeschrijver@nvidia.com>, <petlozup@nvidia.com>, <pshete@nvidia.com>,
	<robh@kernel.org>, <stefank@nvidia.com>, <ulf.hansson@linaro.org>
Subject: Re: [PATCH v7 0/8] soc/tegra: fuse: Add ACPI support
Date: Mon, 18 Dec 2023 16:15:59 +0530
Message-ID: <20231218104559.3286-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZXyCOydl9VOfwKp-@orome.fritz.box>
References: <ZXyCOydl9VOfwKp-@orome.fritz.box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: e49658e9-20bb-45dd-bb2b-08dbffb69017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z643rmyS5VbJLZGgK2ZoGwawqNrXEGDranG5eChVTUVu3GkJv1RK7VbSoWYSiiqKvGe/zZo6hgCMhN7FPGbqIigYB8T8nGkS1em4cBRwVmCCEdnpF9FA1lKzXLzt6Xf+4X0jWL470zKjDEe6im9jVI2k7Xdsd9YZh5v6TW2dQxEFu4p5h2yg3j2ylWSEi7pjWhhoUqv5yg5eXYOkytsMmmmYLZXpG2JoTiiw4pVKpZUe9ORr7xBJZ7lD9VO6sq0nleeKouJI2+telcfxjpAfXmmlB/098blt1HPsFTrx8fifdbrx+X7X3X0t9xvK6fjVfACL8K7GEereJQFXr+fZ9bzu/Uzr3Gbz2IgdaJTIsj2RgTV/jOT4vnREWKRSXNngi8glLgwWlCS7NRexC6s732nkTkDOMRpatoSk6papYeq1Lnh5Bow7izszx3s4+i65LNOFWpUwSH1ek0MVEmAURuViIENq34K37b0ajWjgllaNrO8ryeSC8kwAuskC3o+0taeh9JMzd7eKq4fd9ilB35JqYxEeBsr6Z2V3KxzVmUaBpE6u+9Vp3W0UaO2Q1dikp0JeYA0JGyiBr7x4tvJ3EYQ9e06xavCKrnsMCFz5QIxtqAJkLt719J87em2oOaQb+WVmiqXcR9x222E4kQfEW9jpkHi7IHl06kPvB89SSRJw8mK5gih/eIDHjpnhhK0wQzdvy0QQwNzdJI9YS3qo1Ridm8K23Rbx0hWu97+Gm7DfnphEtaM7xlqkK6V5ndpz
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(26005)(1076003)(2616005)(6666004)(426003)(36860700001)(5660300002)(83380400001)(47076005)(478600001)(2906002)(7416002)(70206006)(8676002)(8936002)(4326008)(4001150100001)(54906003)(70586007)(6916009)(316002)(41300700001)(7636003)(356005)(336012)(82740400003)(36756003)(86362001)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 10:46:16.8724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e49658e9-20bb-45dd-bb2b-08dbffb69017
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352

On Fri, 2023-12-15 at 17:43 +0100, Thierry Reding wrote
> On Thu, Dec 14, 2023 at 06:43:47PM +0000, Arnd Bergmann wrote:
> > On Thu, Dec 14, 2023, at 17:08, Thierry Reding wrote:
> > > On Tue, Oct 17, 2023 at 10:53:14AM +0530, Kartik wrote:
> > >> This series of patches add ACPI support for Tegra194 and Tegra234 in
> > >> Tegra fuse and apbmisc drivers. It also adds support for Tegra241
> > >> which uses ACPI boot.
> > >
> > > Applied, thanks.
> > 
> > I'm still a bit puzzled by this series, can you provide some more background?
> > 
> > Why does an ACPI based system require access to SoC drivers? Shouldn't
> > this all be abstracted by the BIOS in some form so the device drivers
> > can work standalone rather than calling into this driver?
> 
> This driver exposes a couple of things such as SoC family and SKU
> information that is not otherwise available. It also exposes FUSE
> data which can be used to calibrate certain devices. Most of the
> region that contains the fuses is in the keep-out, so perhaps they
> aren't needed on Tegra241.
> 
> I suppose things like SoC family and such could be exposed differently.
> Not sure if ACPI has other ways to expose that.
> 
> Let's see if Kartik can shed some light on this.
> 
> Thierry

Hi Thierry, Arnd,

Although the keep-out contains most of the FUSE region. The driver still
expose FUSE data with tegra_fuse_readl(), which can be used by drivers to
get the required calibration data. Hence the reason to add ACPI support.

The keep-out region is only used by nvmem interface, which allows reading the
FUSE data from userspace as well as kernel modules. Currently on Tegra241,
there are no users needing this information via nvmem interface.

Regards,
Kartik

