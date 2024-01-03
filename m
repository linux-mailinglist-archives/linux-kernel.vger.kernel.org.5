Return-Path: <linux-kernel+bounces-15139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6D982279C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D44D1C22E00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2F51774E;
	Wed,  3 Jan 2024 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Nz5xGUBN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A27171C4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 03:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403316Ii003028;
	Wed, 3 Jan 2024 03:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=subject:to:cc:references:from:message-id:date:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=BYBJKTXu+BqaMKAdDzUNuTkuhM7SIlZurWmerJnll1s=; b=
	Nz5xGUBNATtWaSAEwrf32fNKKYu8E6B0oe6kesLU1t8c6l7bzWG1ZXjMoj8bYXV4
	qDsf4CBzk6yD/c0REQ93BvVY2VIQRLazS28avHMS9f04GeJQ37QwZ7Fqel21spFM
	9vWKRBct40hUDx04Ec75XIL9DvhfYSRWQtMTLAfGZqgsRHMGy8Smpo1GkENNyw26
	9V/u6/CeKWdYpsPUSEwoj9o6T5OTpwHORPNCos6WeJPRzzgKi25AWBsVDs1Vcmqh
	YrGXunB1Db2lqpHAB8uV2TPZWkO5wnnN3Dm5BO65UkdQGHxew1RhRCE++TyqlCyE
	ru7u0qVoLNQQDN77guKSmA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3va8dxbp96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 03:43:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qo78t5aYory4uF0xAuc4/ZrrEBAnadjc+d2PSMLHv4yM3N+fFhKpWJvY0c62nK+Sz1ClT81xlok3G59r6wG4OAEL9gJAtUb/ESxDUGfNa1ihJ+E715wROIl+tRnQa3QkddtRSa1rE7quEchEE3mtT/sZu4DG4eomswx9eipMw3S7oDM9cgX/QTb6f8RsarKL4nlcJoQNqcEBeDZgWpQn7le76h0ZiTNig8dj/jOXjIGB9umF0ru67/cGBgoYKuIVgAFeOJFlE7ZpOCSLQWuVP0aDFzC3RPO8j2emld/eUuGXFKSk5/dmMYl3ZcaqoCfp7Fk/pR/GeOoXnwlkJYsMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYBJKTXu+BqaMKAdDzUNuTkuhM7SIlZurWmerJnll1s=;
 b=fU4TT7r/YOYPzCwH0DTp1bl90i9J3dOXmyoS1OMO6c8ZwVBoxi8MRRWNblrfGjNxLIXbm2kiQwNEYCPa7C3Muw35gYIoab81BpCiG3MMK/vc4jAT5Mvk1bXBINVTUfd886B7mO/TK5Gen/oHe7941U3avsZGaGRXA7EME9tQ47FAIK/qzzixVwmv7q6JtZyMeTabxBFivJBfzHD/dssaOiTy5glRrHQXMo5pKTaBNB47DZ5VaResK40IdEk2r5w0RR9HODV/0u8asLFl/yA2wzmgaHapi2LK6/JbDK1AJAEzO9oRCZnnHuiDTsVIttHRouCrxBMD74FBY4Q0dsZs+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 03:43:54 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::6147:120e:d511:3ece]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::6147:120e:d511:3ece%3]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 03:43:54 +0000
Subject: Re: [PATCH] firmware: imx: scu: ensure wakeup procedure calls
 pm_system_wakeup()
To: kernel test robot <lkp@intel.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, peng.fan@nxp.com, treding@nvidia.com,
        yibin.gong@nxp.com, robh@kernel.org, ranjani.vaidyanathan@nxp.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231230053831.67661-1-xiaolei.wang@windriver.com>
 <202312310227.7eLUYzgH-lkp@intel.com>
From: wangxiaolei <xiaolei.wang@windriver.com>
Message-ID: <30273b0d-11db-356e-09cf-f8a97c0a0406@windriver.com>
Date: Wed, 3 Jan 2024 11:43:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <202312310227.7eLUYzgH-lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: TYCP301CA0034.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::14) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|MW3PR11MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: a3262787-5093-45be-f02f-08dc0c0e3507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nOo5jjJWBl+GypQYyNg9rRjJroW623Q+PPKEJKCuRmIthG1WUuzKs/LhtuzyVAomJw/imCnfrvRPD064VPTPZvea1NUeDzLDCnUGk4HxWty7gBA8RgMiJPaLLopnMvd5O3PBa1VuNU1IuxI7ESZ5+EKyiOW3KOLMJ6v/IIrV/Iwm+hwXXAUL+KHzeDCQPw/ZsK9MZAvtbcAuZNR5juAzo+DVzWJpSRJGtj80eTzhnb6O+S9VlNRux2gJtsim68LAN2Sn7T67BnZ+tt9LTCh4aQ4iXJDhOFcflBJxYLcvXsUYG5eYh2pNVs7rvc6J4+WLOQd/ov3r7xPrjKJHY7X0Z3dC25/672Xfbb3kaxk1mR6Czt/Wedp92TrLhXf9s8mSsf+obHi57lAbROJPQ2C+PT/346Wy9nfP2HnrV05yp0OMgRXAUoMF4j4ORj6UTPcdGYOk64wEWQtYFzDGuLHNi/RHoe9HBn/6OwnN7fFgtWJG+UltzBAvjOi00yNFS1tPX6aAmTZr2LxG2gAT96mOeGkD1lh3KEleIMaKl3rJtII1oX1eaz/N9CNt7bGSdLSDLQireQP/Wqv/8EQge7YnKec/iYDUQZpjJDz4EprAI4h0vsly/DqyjPx0rKVig17+vo82eXqzbM8xa6RNWNhxTb4eynQBPCRFBbDiscL4EoFeYg52crZv8jyCSbmR4nwe61UP43QZnTZr8ETD10/jO2728l7ACOfbyq/MkBj7eVEk/B6ypzJWe7ZvhVAJGEYEPRutj6aXdQe6pPON0KfUwQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(346002)(376002)(366004)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(6506007)(38100700002)(36756003)(921011)(31686004)(31696002)(86362001)(53546011)(966005)(83380400001)(478600001)(6666004)(4326008)(66556008)(66476007)(66946007)(6486002)(26005)(316002)(2616005)(8936002)(8676002)(6512007)(41300700001)(7416002)(5660300002)(2906002)(43062005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VDVQM1hMQ0ZoRVJsUjJ1RXpyTmtibllVRmxlRTEwZXBWL0x3cGFsN0ZlMlYr?=
 =?utf-8?B?SzFaMFpuM1BPSS9xTDFLT0dTMjJxeDVpSEpXa3VQZ1hFd0FHeHlNYmFaTlc1?=
 =?utf-8?B?eFlXK2dFUkVvenlxNVFya1BQdXZVWXppVHdUVWs4emFpVE1LTE5vRUx6VnR4?=
 =?utf-8?B?b3VUN3E0NGFXdE5LeWJFeThva0JxVE42cGJnUVJJU2h6WEU2ZDF4TFhOd29C?=
 =?utf-8?B?dzhzN3d0b3ltODJRa3pZblNFbFhWVWZVMWZ3VGtmcEtzeExqY2xUbzFNNFlk?=
 =?utf-8?B?a3VyZmZjallXTW9wVDlURnFXZ2dCMXRvUi9HeVNlZDhBcjM3Mk40N2xsbjgx?=
 =?utf-8?B?YjZHdGlVVnc4WlZhMHRleG1MMHJjM0VycHRMMjdLZXB1NkFoNnpOQmJCYjM5?=
 =?utf-8?B?RFk2UjhQQ2R6U0JUcklGcUp0ZnlOOGRvdXM4bXJRR2hNN1ZiU2JOYkhXaXpz?=
 =?utf-8?B?M0Y2ajdYRmJlTWc3cGRFcjFPem9oOEtIQUhIQlBicU1KQTF3NUhjeGE2SzZT?=
 =?utf-8?B?aXVhaDlzS3JCQnZxYnJtZE16aFJWelA2RGNQV2tlSWEzL1RIaEoyZWhQU1JF?=
 =?utf-8?B?b1dVMG9WdUJkU3g5T0RkdlBaYnlvVmQvVGN5dGh5KzlMdHl4K3hhMDJJcDh0?=
 =?utf-8?B?a2pKWFhDY3J6dm1MU2VsOXE3NG5JM21aSVhvNld6by9RVGVXODdmd05tVzVi?=
 =?utf-8?B?azJsb1FMR01yL0F6cjFJNnhQUWRVQWR6V2Jta2J6V1JZekd4dGdobENXbWQx?=
 =?utf-8?B?b2xKSGNJUDlaRXExNTRrYy83SGhqRFRTME1HTFYzR0NLaFhDN2F5MUtHUzl6?=
 =?utf-8?B?RUNKVTVXdWhRUzlQdjYxNnNWcS9GRWRhMWl3dTliYW45aHZHYVlkRTlvU2Jz?=
 =?utf-8?B?WjdnQ0dyNVdSS25BbTJtVEljaEVrT01YL3NLaG5Xbms1bzh3U3NYMnJ1eEh4?=
 =?utf-8?B?djdmUlN3MHRWV1NNTnl6OXlvL0NSU0VabnNtTzg0bnE1MnFFYVFzT0ZGclNy?=
 =?utf-8?B?YkQ5SUNlNnpHVnVZNDRPNGtDd21UbG81T2puR0dNUElkK0Nkd0VkVWliZW91?=
 =?utf-8?B?dzAyV21WSmRCWWNuZjhVRVFYNG95NFZ6dk94QVdObWhScC9jSFRFaUY4WTBk?=
 =?utf-8?B?ZSthWkZTRzBFaUhoeTZndy9nSktLS2lucUw4UWdtWU9FVHpiNks2OEVlK05p?=
 =?utf-8?B?VEd2RWhDYjVHUmFsMHprVFlFdEVmZnZkeXh0TkEyaWlyWHNWajF0NnVIcU9r?=
 =?utf-8?B?eExqdXZXZVprZ0NuV00rUDhrc3I0THk0QlVYcmI2em9wbnZXVWhqNmg1aFVk?=
 =?utf-8?B?WndMcmErQmtBYXhZSkxlYTRQUkhTMXZPMHZFWU9CWmNNSEs4TVEvcFV1U2dO?=
 =?utf-8?B?WTl3Wm5jSkRDcmwwUllZSkNCTVEvTDZKVVRmb3k2bXpOL3cvNzAyRExwbCtT?=
 =?utf-8?B?ajdsNS9aVkxHZWU2WFhvREdwYUVjWXFaVUZYd1R2R1N3MExOdW56VGlTci9H?=
 =?utf-8?B?dUw3YlZiaSszVUtuenczNzZRRm9TMmM2Sko5Z2pwblJQYmF3M3VEUDZGbjU3?=
 =?utf-8?B?QytITFpDQzNveTVQSTlrTC85V2Q5eVF5cTNwZWpCOUJEbG5LcTFZZ2RwVk5E?=
 =?utf-8?B?eURnY3lEWG1WZWEvRVhnR3JWNWFtVHp2REwzWWw2RExBK1FxbzhTdWhyNUdL?=
 =?utf-8?B?U0RXR0JMS1JjVldGOEFmVS9IeGo3bm5oNmVBNElPM25rTEJ5Q2ZtVGI2U2g0?=
 =?utf-8?B?VHBQdlBvMFJvOXNYVko4TE44dU16RGdpVkp3azZvWkJ4MnZnNnYyWWJlMDBm?=
 =?utf-8?B?WlJod29CM0w3Yzl6dVR6ZWxTWU5IQnBSbXZ5YWJuOTNUZU4ySzZSOTZ6OUp3?=
 =?utf-8?B?dUpiSmtSRVlUeUpIams1U0tRbkJ4THgzVlU1MDRmZ1RaS2J5c0dWMVVoVlpl?=
 =?utf-8?B?LzBHYkJLcmZ2cHY5SW01Y2xXZVJrUXRiWXZiVGYrc3JCelZVNVh0SktocGJJ?=
 =?utf-8?B?U2VtajkvMHVNSkFRUitVNko0WDREVmxiOUdIU2o2VlJIQUNOSklwM1FQUzNR?=
 =?utf-8?B?MjNQMnpoejExYVpmNTBwcUdpNHdTaHhEQUlPQkhEbHRrUXh3T0dTZW5WaU1J?=
 =?utf-8?B?d2JqMWNJeEcwc2ZxZHRIOFk4ZW82MjBFUUJDTTdNc01pT1FtK2hYd3RHOWlI?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3262787-5093-45be-f02f-08dc0c0e3507
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 03:43:53.9661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7VfKnKU8EL/pHuUf+RJ5HRFD4GCBGVo6h+4XsodZbJXci2nPNb94xAW/8CGqnX7qHI9PPI+cTKqWOE2+c+5dU4L5o3imQ08CccrthcI5ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4522
X-Proofpoint-GUID: KNW6eEHWzqQbIoXw8oeJVvWjP8HcMGMI
X-Proofpoint-ORIG-GUID: KNW6eEHWzqQbIoXw8oeJVvWjP8HcMGMI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 clxscore=1011 mlxlogscore=999 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401030027


On 12/31/23 2:55 AM, kernel test robot wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hi Xiaolei,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on shawnguo/for-next]
> [also build test WARNING on linus/master v6.7-rc7 next-20231222]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Xiaolei-Wang/firmware-imx-scu-ensure-wakeup-procedure-calls-pm_system_wakeup/20231230-134202
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
> patch link:    https://lore.kernel.org/r/20231230053831.67661-1-xiaolei.wang%40windriver.com
> patch subject: [PATCH] firmware: imx: scu: ensure wakeup procedure calls pm_system_wakeup()
> config: i386-buildonly-randconfig-003-20231230 (https://download.01.org/0day-ci/archive/20231231/202312310227.7eLUYzgH-lkp@intel.com/config)
> compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231231/202312310227.7eLUYzgH-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312310227.7eLUYzgH-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> drivers/firmware/imx/imx-scu.c:365:32: warning: unused variable 'imx_scu_pm_ops' [-Wunused-const-variable]
>       365 | static const struct dev_pm_ops imx_scu_pm_ops = {
>           |                                ^~~~~~~~~~~~~~
>     1 warning generated.
>
>
> vim +/imx_scu_pm_ops +365 drivers/firmware/imx/imx-scu.c
>
>     364
>   > 365  static const struct dev_pm_ops imx_scu_pm_ops = {
>     366          SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_scu_suspend_noirq,
>     367                                        imx_scu_resume_noirq)
>     368  };
>     369
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


drop this patch, There are still some issues that I will continue to 
research


thanks

xiaolei


