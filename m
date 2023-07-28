Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41494766679
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjG1IKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjG1IKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:10:21 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A611E3580;
        Fri, 28 Jul 2023 01:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690531812; x=1722067812;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m2s/luEhr25xu3a++0jqnbIRAb4Gvzmi1xZb3Wboct8=;
  b=fieqI8A3pqBsV3NoK3PcCtoLmJscApGyW0AMyfIGH+4b1Snl+3Ok99tq
   g2Bnnj/ym+JtklZfLsRyxpr7LKQawerBD/E2r9TTLV5irP1X0Sk76jjfa
   gcR3u70tCmzBEIYIRfBpO5odrswoWrKOduDvR/AYIo9FQcCWLDYMqCP0s
   8iKLQM7jbz2/iDT2SpBJMiDusVIveW8QWnmIa0QuYwfMFShUrDf5zCKKt
   yavvMLGOsZWGm25C8bST7TZY2aad0AoYNUnSn5xUqXHdZM58pCH8WZ32n
   pdQGNO5aLq8sVf93zHIcbDRwFXWCx3+nRAWOMSP8xwKfMpkMIotFC3Cyz
   A==;
X-IronPort-AV: E=Sophos;i="6.01,236,1684771200"; 
   d="scan'208";a="351359044"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2023 16:10:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edsXvTbMu7gshcftyNSHFG69tOUb1r3nLrnW8AUk76jCriVF5Qvkceqlgi2A3oUPScxN+sdSzt2gRQZm4HNxb4JHaPha4OqU6J6TMdUs40gzNriYzh4DUaEkt4bvw6PW6ZShLKjP8/g8VxMv2FsuQ4ZqSbEbzPCbxM6VVXI9zGMIJnDsTVatGrUGg0085RBP5Ffzkzm2kpMO5uJG/esRQnBVwVzPrHcg1kHn/j+XD+DIoI9ggtMj4BYimaT3STY53NTd1TtrSMqZvcqPE9qcPL2+exQwdgIgTsqWk7THnMXD39qQ2kXC4DadY4YH8g+xuHE08sQ4+Xkld84+mO2bRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6BfwYGmkUPYolhaoXuefPXHUfpquNN4++LCBLr1dAY=;
 b=T5Qe46YRcmQpAmgiUFEuETv0OAlwvX9VXwYXeU23embq2W2gYdt50z9aC9KF7ef76gVcIEBXwVXHWKWF2G/UdyGYsAXEyvJEl81a7S9eYPk7iWs/dRV2Fin15ihpkIKnFmXCDqgmKWono4O8BFrM+LmiU8XRNbCGRFCwDeHb0q3C9TE2yrDtNefMLTjKeA2z6wY4kkD3MzP9rNAja1x+bSxuycSEDW3MA833MM6m8U1Sx/iypb+ZKqVI1lLWbl7be6OM3cQFrJX5FvoEWhlHLba5qYNhRsdCPj/qrTT23G/68hFIgRzZOVj/7LCMKS/0zUuxGIRW7Xp1SBqcl1xXzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6BfwYGmkUPYolhaoXuefPXHUfpquNN4++LCBLr1dAY=;
 b=BJW1es23l5tWWlhvR7MHv+mgRE6+AaU5wpN1Ra6i/aVfXJFhGqyTmdfVjd1UgKL391lInatzDVRCGz23akkp6pMe5B7kmJ9z5nUuiKT5dR2hxlJUlL25l+rABxwj5j+846kNDKVBbRnhXj0Vb6PFgA8ZLBzU+c2DW/Nxl1PyPmo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN7PR04MB8766.namprd04.prod.outlook.com (2603:10b6:806:2e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 28 Jul
 2023 08:10:09 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 08:10:09 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v1 05/11] nvme/{041,042,043,044,045,048}: Remove
 local variable hostnqn and hostid
Thread-Topic: [PATCH blktests v1 05/11] nvme/{041,042,043,044,045,048}: Remove
 local variable hostnqn and hostid
Thread-Index: AQHZv79HJRql4wyHS068WCBIAtFTIq/O1lkA
Date:   Fri, 28 Jul 2023 08:10:09 +0000
Message-ID: <keqqev3paa2rtk5ysaitglnqfokeph7uvqh4z377atjlow65eh@buvr5azvul4s>
References: <20230726124644.12619-1-dwagner@suse.de>
 <20230726124644.12619-6-dwagner@suse.de>
In-Reply-To: <20230726124644.12619-6-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SN7PR04MB8766:EE_
x-ms-office365-filtering-correlation-id: cd5698b1-e2dc-4e57-dcd2-08db8f420f97
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: swesKoLAGqa8/RxygAXHV9DFrEJppg+hCCv51bJ1N9NKNF/u8ZEo0Z6DNXtU/pIy3Gv5N++NnJt72e5BQP92sVv1ZzGrsKNf3w2tSF1TgXNXdVA+W3S5zhbdmCO2uXqOXosF4bOA++YdIEk7BseYHZzLNliB8zrKewx27AfvFX7n/hOXqWX5McLz5mbIraZEamZ82rI2i9OHItE/7VYNva230hUX/SRRg9h8VuLXax0ch+RpYYpntzgYjHwu3JMsQ8d/o9clevxn1yVkCqah2AEgi++z0iNbSbuvRMEXcCOB8TlV3ah/y1esFs2qihR043zwjY1N4rDyAC7p1lqLHJOEknSQHHNfMo8en5EQppYgFDfatznwBBbrDWgHXsho6slVqPZK8/HkSC7FmqpkRLHqUojmIupGy+031BectU7YGU0vF+rNPb96jvbzh9U10n9yfC6N15GlDGpSngvbJEuyJQ0FHiTYJQn7ClluNp4ZUc/N/cYXzPIFdxnAhi4VVKOCS6+34Pkbhz7OUQnwZYZeutSad+9kurg6xKASyihVRBSIidXkAPQTKf5TTlBorErY9UQ6hQzqdcYS/vSniZ2HQK95vA4Iq2fIv3aA8fCn5wYfTOLbb8YM6fR5pqWn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199021)(6916009)(8676002)(4326008)(44832011)(64756008)(66446008)(41300700001)(8936002)(66476007)(66556008)(316002)(66946007)(76116006)(5660300002)(91956017)(38070700005)(6512007)(9686003)(54906003)(2906002)(6486002)(478600001)(26005)(122000001)(38100700002)(83380400001)(186003)(6506007)(71200400001)(82960400001)(86362001)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q2cOeHyShw6walxfd6pMJqTAoDVfsiKteN4eawC8rIEM694ma+ZMUryHTV1Q?=
 =?us-ascii?Q?1QtZx+oUB3+PptGrsJc7GsT7AHcDQ4MgioeDzrHq3nFxl9TYxWtCpq3W348e?=
 =?us-ascii?Q?91H7yhKw50nBhnxSh44ET/biYQV48Nwtm24t5tJ+4F0zPu2Yr6CEEx/ZlI0c?=
 =?us-ascii?Q?01BL6HFqdSPt31A9ziNxSg4Wyvc5Zq61MFFAWOcw91VgPo9whoD0W8Uz6oyJ?=
 =?us-ascii?Q?CfFwgD5H9iaaYUYP9rGTthCmd2+1U25tzrzCj8op+HGyh+tPEqLp706F+g5L?=
 =?us-ascii?Q?T0yfVdJf/GxvT+mu9PJaNlLIFaE24dg507FHYY30FsMbGrXo3wIVQu2mOk74?=
 =?us-ascii?Q?rRJgOsABbl3pnNdnZqS/LonGR/vluWQPJLhDEpa0sMM5wE8bYTcp5Ga1m55W?=
 =?us-ascii?Q?2pQMFf8gD7mZdjNDZYAeKi14s8Lw3pSATxliTebs2jfHTkYlGsRLG8lt2cn9?=
 =?us-ascii?Q?SEL1IEX9MVNuMaeAs1DAh+mtt1jPQNqbD57/FIAXhnS3Y4jxzItYbNxYhRwD?=
 =?us-ascii?Q?LNdN+H2reLbZomFaecnUCAX/pBMYiUWbn4lXvo/p3p1cJOWlxP9GKCyvtFpM?=
 =?us-ascii?Q?Zio8tU7QwualMn4hBPXyXhDwpEBST57B1xrhM3rT39Oqp1B3J6Piv5tfeIPQ?=
 =?us-ascii?Q?bBWwzHIh8V10Dtq4O3R8v/rcLtv9RJ/kFyRQravji6VZ0FsLX7L+C87r2SVx?=
 =?us-ascii?Q?MSXi5XcbS/emsn+ZpkZ+3AZtSD3u9LjEkYHEgDLSqEE+i49+AMbJpo/UuGi4?=
 =?us-ascii?Q?sF7LSdEn3W5THmxDsnRTOQwWmFoOo1zSuu2Ca0gueNbm9X3czJHmd0pPrxD1?=
 =?us-ascii?Q?i1zOKWTcJ+SdUGSIzCp6RcjoumKBgBsv3ekLLkN/I7pO5Zpma86kSvhUEd26?=
 =?us-ascii?Q?KX9UXzSM9jD+uc61JzH+AbZA7e1/GSCK0412V/0mQLZ6Q61OKv+kykwrraxZ?=
 =?us-ascii?Q?RETTZVlaHIyctQ4/PLx/FKryHZlToWGaJkbUWR1AhUOKPpbghLrQwTFXCgWf?=
 =?us-ascii?Q?cESqQkoj8zK9nddH7jBAXEqt0kG08ktCI0C4NqGd+nOANkSY0TNmna61yE+r?=
 =?us-ascii?Q?hgf/mopF4ADj224YW3xiQXOntG2oGhSk/G4J2QOK9yOxDuWUM9kBYpR85kF+?=
 =?us-ascii?Q?p0xbWZOfeczBfJELpKDOsqExaMlFoEd4Wr5fhOB9UP5k1pPvW9NxLhkb+0uq?=
 =?us-ascii?Q?HQgMYV0pHEhpzXL27174J+cFBw84f25nh+pMRVqFmBe0RLfpJBh7qecnY7ns?=
 =?us-ascii?Q?OFVGtQoRWsk8kIObSioZ1BdmHTOKLNV0bMal3jcm4r6iuySjIgTI03ndlXlY?=
 =?us-ascii?Q?Gi4Bx/0M4dj3SVK7/emKz4fHUJtrepZTHWsa1gE7R7sT0bmVZKglMjVofiVi?=
 =?us-ascii?Q?1rD6qOHfF9xV+zCubgQaOxsqSPJuiPe+XvdQ1ytlUyCXj4JSldP1vLercME1?=
 =?us-ascii?Q?UNgm4K+MweYSU6/Vv+WzzFb3EDz2jRWAAlml8qPlpF1JlFIpC+s9D8h17CBS?=
 =?us-ascii?Q?GfXAZNzy8dqVCF2LnfM6OUziPL/fUdynytjI/9SfKkjrG+KnIOHTelvlsoO/?=
 =?us-ascii?Q?SIHisWIPNBgP+6IfWZNRdywtKYmuZHowyQlWt1q471o7syodznh1Gn4TXjRN?=
 =?us-ascii?Q?1+lO4QIDH/fy8V6leRAd260=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <73ACAA66A2869C46811EE935F1F1E7F4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?oulO6/5YL4hBN4hH2iu7Mt0SLM39F1W1JJ/E1bs/iYLb+FjFSYd8qNzJlnlo?=
 =?us-ascii?Q?9kKLHglu4gA+HzBYBwcnKFjPz58Sn+jOA6wgkbcES+5ZrBhlSbAjajA4dd8j?=
 =?us-ascii?Q?cpsKUOGjcx5FBhHGWXG3woRtsk3/p7cm8S0GUnS3PH1ESOR97RjP5USUY1CF?=
 =?us-ascii?Q?I8ly4ujXq6QjKkU0O8EhYximtz7UiJuJBZ2705K8qHRN89u7/kQzxW4/9fs9?=
 =?us-ascii?Q?Jy8IoQUHq2RVwRFxs2xGh75YVJSXHQQDNlfR9DOn1bmXgLrvieiWb5YMvR7u?=
 =?us-ascii?Q?qkV9Yq+CxDyuuYDtzx40u6jFyLS+FnayP6hT95s9P+TIvOBvV0cl325hv818?=
 =?us-ascii?Q?1szZeSH19lV2ZQxnjI69M3XAoqi9xuEGLz70QLvhIWeZLIIH7/L9jugKwxTR?=
 =?us-ascii?Q?sQ/+vKPbQmNaEInFaQTcdccGcDTwd7/9EcvlROGAdAUM2TFtwrkA0hZlLvA7?=
 =?us-ascii?Q?CPKDcDa4JemKy4DSqDTnTCIya8gctiBx6x9tZi+uHMdglY17h1WqTfZvos8s?=
 =?us-ascii?Q?vPXasRZ7SyUArsVHBI2O22pXPWfQqSExQDGkrruWKghFAZKzWsZv7mn6cdM9?=
 =?us-ascii?Q?2rrvIfTMHe1fHe1XhBGN4MMPfYHfENChCHJcnTwraIIaGYiMb4S4ZI2t6srs?=
 =?us-ascii?Q?T1YAW3tRYTHchfgMeXY/vtG3A05mlcbrpzYbSgJzXdqteTPdDkgmfu8S6H6H?=
 =?us-ascii?Q?5em1kGKwPZ1wh/Y62ChQYuYj5vdfgrc1idi2gnlrweureXsayEuSOS95Zs4B?=
 =?us-ascii?Q?W1EW623rpzHk7w0snysSp0Izuhu9MPRLZjzGtDds4sWl+yGi+I3nRevQ0W65?=
 =?us-ascii?Q?bSHPmp1Q3zIKerA0lT0EjAGgY0Duiw1NXx4CMvqvfV/ikWAuUTKDDKSvu2uG?=
 =?us-ascii?Q?UWWlPYE0vPzpNZcle904Ny6306//0+6ZTY/gyd8OB3cgEs963wCm7MOWrEdC?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5698b1-e2dc-4e57-dcd2-08db8f420f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 08:10:09.4791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c8UvrVI28rwHmK+3SsxCWxrmCgPYsgKkFphHQWPhZZh5L50p3PCmNE+LKxUyu4+8uHNwwhX7r4l5lMNNoMTzMm44KQz95cujUbP2IshbPoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8766
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 26, 2023 / 14:46, Daniel Wagner wrote:
> Commit acc408477e85 ("nvme/{041,042,043,044,045,048}: Use default
> hostnqn and hostid") switched the test over to use the default
> hostnqn. It missed the change to remove the local variable and
> use the def_hostnqn/def_hostid directly.

[...]

> diff --git a/tests/nvme/043 b/tests/nvme/043
> index 6392bd8b2492..5569a7a58ad5 100755
> --- a/tests/nvme/043
> +++ b/tests/nvme/043
> @@ -26,17 +26,13 @@ test() {
>  	_setup_nvmet
> =20
>  	local port
> -	local hostid
> -	local hostnqn
>  	local file_path=3D"${TMPDIR}/img"
>  	local hash
>  	local dhgroup
>  	local hostkey
>  	local ctrldev
> =20
> -	hostid=3D"${def_hostid}"
> -	hostnqn=3D"${def_hostnqn}"
> -	hostkey=3D"$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
> +	hostkey=3D"$(nvme gen-dhchap-key -n ${def_hostnqn} 2> /dev/null)"

As I commented on the previous patch, the left reference to subsys_name is
replaced def_hostnqn. It means that the -n option value changes. I guess
this change is fine for this test. Could you confirm it?=
