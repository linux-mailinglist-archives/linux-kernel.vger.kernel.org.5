Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BB37CA368
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjJPJFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjJPJF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:05:29 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA47101
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1697447119;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=iG4vV8SUfVkWxaM0YcZXftPQKXDuDMAU66rJgEcW71s=;
  b=CDw8PRb2pcLaN9V92isaE5xuzMbjHTbuwXLB7dpvm4QiO5/ZbVC8Pxvg
   yXtYQex9QI3lUTBohW5x80GCMMRQ0k3pgYH1Jbq5rUiUC4JKAFX9dW+98
   NI2gQtG+kKhiI0w+rst4xv6HzLWCFS7e8qrNWxeBuxLC0wilmJi3jgadt
   4=;
X-CSE-ConnectionGUID: O2JRFuLYQC2llNRhLWSpkw==
X-CSE-MsgGUID: 5dS9rIoNTbG+UoOOdZiWUA==
X-IronPort-RemoteIP: 104.47.70.101
X-IronPort-MID: 125674779
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:VuDy5qr3e+NrNw6LEM6dcVM1Wp5eBmKDZBIvgKrLsJaIsI4StFCzt
 garIBmAb6qDYjf3f9B3PY20908F7MLXx9BhHlFtri5gFitE9puZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbOCYmYpA1Y8FE/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKq04GhwUmAWP6gR5waGzidNVfrzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXABdXTCqtmsaH+ZnhTu1KvMQHE/LzP5xK7xmMzRmBZRonabbqZvySoPV+g3I3jM0IGuvCb
 c0EbzYpdA7HfxBEJlYQDtQ5gfusgX78NTZfrTp5p4JuuzSVkFM3j+CraYKMEjCJbZw9ckKwv
 GXJ8n6/GhgHHNee1SCE4jSngeqncSbTAdhPSuLkqaE76LGV7jEfM0wMdFydnfOWyXO5fPVTG
 U0rxwN7+MDe82TuFLERRSaQpXeeuxcGVtl4Eusk6RqMwK7Z/waYAGcfSjdLLtchsaceQT0sy
 0/MnN7zAzFrmKOaRGjb9bqOqz62fy8PIgcqZyAeShAey8L+u4x1hRXKJv54C7K8hNDxHTD2w
 hiJoTI4irFVitQEv428+V3EmDuqqoL+Uh8u5g7XU2Sm6St0fIegIYev7DDz7/xNMYKYRVmpp
 2Uflo6V6+VmJYGAkmmBTfsAGJmt5u2ZK3vMjFh3BZ4j+j+xvXm5cuhtDCpWIU5oNoMOf2Dva
 UqK4QdJvsYLZT2tcLN9ZJ+3B4Iy16/8GN/5V/fSKN1Tfpx2cwzB9yZrDaKN413QfIEXuflXE
 f+mnQyEVB721YwPIOKKetog
IronPort-HdrOrdr: A9a23:kWdZpK2tP6mQDTNe3QVHdwqjBEQkLtp133Aq2lEZdPU0SKGlfg
 6V/MjztCWE7gr5PUtLpTnuAsa9qB/nm6KdpLNhX4tKPzOW31dATrsSjrcKqgeIc0HDH6xmpM
 JdmsBFY+EYZmIK6foSjjPYLz4hquP3j5xBh43lvglQpdcBUdAQ0+97YDzrYnGfXGN9dOME/A
 L33Ls7m9KnE05nFviTNz0+cMXogcbEr57iaQ5uPW9a1OHf5QnYk4ITCnKjr20jbw8=
X-Talos-CUID: 9a23:mDc0S2DniGOB4+T6Ew491nQ6B+QUS1aHyHP2GU+cNl1xS6LAHA==
X-Talos-MUID: 9a23:Pif4ZwXmcRdSnJnq/GLgv2B4FcBO366BS30KtrIKici7CAUlbg==
X-IronPort-AV: E=Sophos;i="6.03,229,1694750400"; 
   d="scan'208";a="125674779"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2023 05:05:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2gBcT08NsK63AZ0W+MyzLwDkScfQLUmyOjDL293y8a6R/evM4M0P13cLZhnA3j51XLK83m3s2qLFyd/34augYIn+ycDXMFPuaHIN7vjFZWe9jOt2Jz3s5RR6VYiBGmFNq9EV8FZuhBS8m3PX5vWS2hFd6+s050Xw1z1JYTMRClhRLmaUN4Ze8yYGetXXLiy7leBNZal9XtYt6EC8K5Wdhbe5y0vU9vX+9NIu2rdDU+TW5tHbHd0Ss/q/UGJb8tkfvtc/acM/kwLCDBPfEgkzzvG7XOMNFw2VAJzGALUF1Em7kNHbTGAuisWp2CrDpdA2Bgv1UJO6+0kPd5yOD4HYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQNWR/uKHtslOLw/DN5/pH6PYcISdgRH0Qk5gK7rFDw=;
 b=L/ry/2xGl0OtKb+ZPK50280Rz53xaMDEqeHrW3ys3PJ3HUUYz+uCGseH1e0w7+eremQuzjspaJbYoc62/jHhAMOdzPH3rUhez3Z0f59m+sKpB2uMKyRsoHi9u3hrFh1SZvJlzI9murSQOvpkCI/iGAkjLyEXxVopOAGFhsk9BNqpssBTMlsswDHedz0QN5zmABcRC5VHCOhog6Y9F/1wTcimD3p5jMI0wV8sL5mTs94jl3Ms6f0WBXQggY1ecuHNAvx0Lpovw9ci1lSSWKebf/ZAmQXiVRFdEbqIy2P6h0L03iqQFwbCRoq0NaNLnChbpN0dbvW9o3D93yjx4aPRCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQNWR/uKHtslOLw/DN5/pH6PYcISdgRH0Qk5gK7rFDw=;
 b=o2ZCb7iezMDTLQe/Vm9vMhkhe+Hvih1jKbos62R7mnsyb0X/ECqdWnrnYVSRzFEjZDNF1tvgGhI3MzrxmK66Ilei159zVvAf2XKMesknaPHdcj6zOEJVaF1u8DZRAXH3X6+MtIqe0ZbXhF46RWOFFIkGF5zPxVTHtNmt73hlWxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from MW4PR03MB6428.namprd03.prod.outlook.com (2603:10b6:303:123::8)
 by CH2PR03MB5205.namprd03.prod.outlook.com (2603:10b6:610:9b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 16 Oct
 2023 09:05:16 +0000
Received: from MW4PR03MB6428.namprd03.prod.outlook.com
 ([fe80::831e:28d1:34dc:f518]) by MW4PR03MB6428.namprd03.prod.outlook.com
 ([fe80::831e:28d1:34dc:f518%5]) with mapi id 15.20.6863.032; Mon, 16 Oct 2023
 09:05:16 +0000
Date:   Mon, 16 Oct 2023 11:05:10 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3] xen-pciback: Consider INTx disabled when MSI/MSI-X is
 enabled
Message-ID: <ZSz8xu8E9-02Ej8D@macbook>
References: <20221118154931.1928298-1-marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118154931.1928298-1-marmarek@invisiblethingslab.com>
X-ClientProxiedBy: LO4P123CA0185.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::10) To MW4PR03MB6428.namprd03.prod.outlook.com
 (2603:10b6:303:123::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR03MB6428:EE_|CH2PR03MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: cc68af04-4af9-4031-76de-08dbce270359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNjqqzQ0yJIAIdW3tH6AI8TTMyblLR9l+GCBkQPvQcyhkQxAFqPtAx53bWJl2cg3R2qHopiauF6f9eYofsk9we/I3GGMIKAdchM+WLKEVXTwdS+K0QAsOzj0xPdFC3NEfmPH8vB/3GMAP3KvaFsboHRZ1K4yaFDC+ImJQRcVIVeLBaw8VDKbBblc360b9QiFFh3TNLszWAgNCbcMYJNzisXf6iNliFQzRFxCFm7in4OsMyLrUgbo1FK2rUi8N+Cqn5QDpU3Qew8mUDCAy2PR6SlQ2kavPWPNF4hZOmC56GMR9KIM+sJ2dN7AP16DHdCA2uqk5NVlwbEkWu0ESygzEgsGgxIFxN+WO341yZ4rBQ/eJeYOFhWSCk1kF20rO4gzLP9p57Jqm8uFmjxT97slZVrHGywgfutfnopnI6W+ykcdoErILvryAn8wjY7Lwo+RPRlRKcGEq8fXOhrajyAEPxqV58my2m6AkV7rNFuoIALFNfOC3amdNDOeBk/QgH4FAkLa2dpe6tTjYQzdhwtNbo+0oFkXXiaqK/21ILPcPRCJnrNC9ovjr0yJ8P4akzYD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR03MB6428.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(85182001)(33716001)(82960400001)(86362001)(38100700002)(6916009)(2906002)(6666004)(478600001)(9686003)(4326008)(5660300002)(6486002)(6506007)(41300700001)(6512007)(8936002)(8676002)(66476007)(83380400001)(316002)(66556008)(66574015)(26005)(54906003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXJ3VHRobzNWczY2UlF0UjhRU0VmSkprRkxMQU5rTUFiUzNremszNWQwU0Vo?=
 =?utf-8?B?bFp6MDhhVkRKLzdNcmx6cXZqME9lbktnRHUzVHJkUTlONUF6cUswVzdRaGRi?=
 =?utf-8?B?MzVOZDJ6Z1cwbDEyRVN6d3RuY1lOUFdDN291TkR1VURQKzlMWU1tU0trUEt0?=
 =?utf-8?B?NmRJeTJ6am5WTXJkSFU0ZGo2MDJtbjRSNWw1N2NNekxGZUpYampTTjhnOWxq?=
 =?utf-8?B?TUgrelV0dEVxNGp0TWdUaHNKbFdFOVZoZW5aa0MvTkhiRFZtWDdxTUoraThu?=
 =?utf-8?B?dmk3TGJueEMzdFlMUXZKeUREU0oxd0JScWU5Z2xsYUs3L3Q0R1ZrMlVwbmZw?=
 =?utf-8?B?OTFiZlFpeklyQjFmaVE0NUY5alBlY1dCRzdUdWJLMWpHdEd0TlN6V2hGTWM5?=
 =?utf-8?B?MkZQMVpMVWYycHpEOU9NZ1BFNVVIT01YR0tZcEFweEpkYXZkY0JNMEdadlNR?=
 =?utf-8?B?V3VvZzEyR2JZTThnVnIyTVNyU2dDOWpMS3lOdEpxK1pybElyT1c4U3phWnZV?=
 =?utf-8?B?dFZDWmxaSUpMeWZ2dXVld2M5MjZxZzR4ZzJxdUtMamttVjY3QzdnZmtFMFBk?=
 =?utf-8?B?L2pmalRhODVnd3BLazNRTVFUT2Q4N3hWT3d5ZXQySlI4ZDQ4Q2lwVUlQSExr?=
 =?utf-8?B?cm90c0VsVVdxdmkrSGlhRXRyMUlOT0FhdzdIcnE5RUNSNkFYREpEWjllVklY?=
 =?utf-8?B?RHJQd3FFS00zK0R6SDdtTzkvQ3oyRjlxY1Rkck02bFRFcXQ2OTFSQlBWM0I2?=
 =?utf-8?B?dlpTd010dmMrMTdrUDcrQkc4dUFiTGs1OUZoVkQ5NHAzWkU1dmtJSU5mSklx?=
 =?utf-8?B?cEo3OHl2cFIwVmZRUHk5Q0VnL0IrcVA2VUk3Ym5WZTVHVGNIU2NZN2s2dTIz?=
 =?utf-8?B?UHVqREpnZ3JYZjgvRlYzRnBJZEFmQkFVcVdSU0hMOU9MbmRRa3NpczA4alNh?=
 =?utf-8?B?UUdMU1UySXdqNmdmWWR3U0ZKRFBSOHdPZ3dPdG5QUEFPRVZOVUVvZXF0Vk5O?=
 =?utf-8?B?ekVMck1FdGdDa0EwNngrNzU1SXNkbXBZb25JM3RVMVc1OW9qUFBxTkdMazEv?=
 =?utf-8?B?WlRoN1U0VDhIK0hZS0xucmllMkhUTUFXZXo5Lzhndk1yanFYQ29La0FaaDlF?=
 =?utf-8?B?YXloTG8vS2Y0bE93OVErZWYwT2NUV1MxaVppbGNXSGYzZyswRTQ0aUloazRG?=
 =?utf-8?B?blNWQ0NJeFRiRUJlV1FzY2pUZG5UdHkrZDBkcFVKUTFacyt1T2JhSG83NXJr?=
 =?utf-8?B?QUY4MzQ3bzAydnMyMGw5SGVDMmdOYUx3b2Rad0g4V2UyTVlSKytqSEkyM2hH?=
 =?utf-8?B?aFlPOENIN1M1Wm15Lzgvci9lcXlXTnpYYmxBd1UzSnZKRktxVFhoMUlwRys5?=
 =?utf-8?B?QVB5YTNDVEordnYzL1VYUWszTFVaUW1OWEZlalBEdVpscnYrL1Z5WGVibElh?=
 =?utf-8?B?bS9tR0ZHeG9RNDRCQmNzU1UwaHJGMWFTUnVoOHJGb0FLYVNHeFdTTjhsTWk0?=
 =?utf-8?B?Mm05bnBVODNXQ0ZWNnN3SHFCZis0NHY3TStiOGxoc2N1bThLMVVqQnl1WDBT?=
 =?utf-8?B?SlBzVVE2cFIrYlpBLzhhR0ZDeEVRS1NxNURGWnlVMnVyZExERms3eCtoY25o?=
 =?utf-8?B?WEdtc2dJZ1dIWExsUU85d1RnYkl0U0xXa2VTZlgzeGxDTGNNMjRsRDdrY2tU?=
 =?utf-8?B?Y0xGTHZXRHNpK1greWdMV2x4c0pBbFRtUzVXQ0R6dTMrNEVzWXJibmtyUk5P?=
 =?utf-8?B?U3grbzAwTG1DTHVLWXBVb1lFWFEyRWl5R3BTcnFWR2VJbFI5cXBHL3lMZ2ln?=
 =?utf-8?B?NzlEVWJaS0Z2R2hNbVVPME1pRlZwZHQ5SWsrWjlMYlJqemdRbHZEdVZHN01P?=
 =?utf-8?B?aUpnTDlRTFJSb2taOXhaZVBwZ3dyOE5vbHhtalBNdlRQbldOWGFzUEk2Tlpr?=
 =?utf-8?B?THdXVHZRVGxtcVdUdmx3UEYwV0J1RGQyakVMZmRmclNlWTFNVkZMVTNoWnZH?=
 =?utf-8?B?SDE1V3g5aHVHV29vbjJSUWxRa09EK0ljdzdkb2xNSE5qV0UzMUxBd24yTnM1?=
 =?utf-8?B?WWExYytDeUloRHhDSjJMQndsZk5xVGNzNVo2U0txNlh4VW9JeGZ2Zno4TXN0?=
 =?utf-8?Q?JWY3aFY2/Jbp9nW2WCPc8szqW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SlpZRmsyeTR1SFBMTWtWTlBuaE03UWJJT3hJUHJLSXk2RlZEb3dFeGo5THRv?=
 =?utf-8?B?QUQ1UVFEeFdieDVQeENBeUI1OWhJaDQyb0N1NXdPSjNwRGRJSGRRUWE4Mm54?=
 =?utf-8?B?Zk9ROFZzeVBNY21FRVJyTnc1eE5COXRRdkNZaU1ISG55TnNxem5XekdHSG1Z?=
 =?utf-8?B?eTJCZUw3L2xkam0rWnZ3YklDOHZHLzVrOXZyRUEvZGR3WFNyc2lBdm9XSm15?=
 =?utf-8?B?VE13ZjlNSlRkakprL21uUkp1YnhnNDY5R1dRRnhsZmlsNXY3RDQvWjJOZTRw?=
 =?utf-8?B?NjVVOWtrSURyRXJieC9UL1FiVFRSNFNjdDJqV1I5VmZOdm5qOWtlS3Z3RWIz?=
 =?utf-8?B?ZXpaMGxDWEJHeHFGWnZwV0pLL2xkTmVBeDA3QWF4enpJei9ua0tiUHJvR2l3?=
 =?utf-8?B?NVRRZFdQMFhhRkVJVk9ia2huNDl3SXlhOGt5K2VnTFV0a2pIVzYzZXRaSEo1?=
 =?utf-8?B?QUVWRkxpay9iVGdBL0pNYU9OK2R1QXFibkxiM0Q0dW5hdFArbjdPd0lmSXNy?=
 =?utf-8?B?dkF6dEFJbjdUeXZKSmhOanoveEQ1ZGxHRlNsVERzallTYlBCSlFWNkd3OEx1?=
 =?utf-8?B?YkJ2WHU3U1ZrZVA0QzBJaFBFYlNWRmZodm9nejM1dU9nVktaZFJBSzFZQ2NK?=
 =?utf-8?B?azJIZkd5d1lVYzdpemtaWUp1YVpFQXZsQnEzcjZGRjVqVXZaTDRkMnFyKzJv?=
 =?utf-8?B?dWJCZFoyVTB1WDB0UklPZ09hbTJMcUNTT1NtTFhLemthTDArQjAxYlhKNkZs?=
 =?utf-8?B?MGx4KzlHUkx4OGE5eklCaUNrQkdFTjlnVHBlSWlBN2FsZ29aMm5qQUlwd3B2?=
 =?utf-8?B?UVF6Q2pVZms0R0FjaWM3M3R4S0dNMmV5MkttemZzU0NyUW8yQWhCSXJyalRv?=
 =?utf-8?B?Q1dPTDZMUXVGMVlGS1B2dTRWT0kvSTl5OExyZlpaUTNOdTRoRzJkd1dqRHRx?=
 =?utf-8?B?UG53MU5yQmdxci82cnd4NHhCUERlZmRRLy84SDJia1NOODZBRW0xZjRXYVVI?=
 =?utf-8?B?dWNwVU5OcEZPWjltSXB1YWlRMWRwRUZ3T2Y0YjEvclpmUnVEL2FLV2NQZnhJ?=
 =?utf-8?B?cVhHakRVN0RhVENEV2Y5Q2JvYW5wN3FhMGZVUHhNSU1FcEZybmIxOFBpM042?=
 =?utf-8?B?TTNKZ0hsSG5tNHBiaVRBRG1DR3M5NnFPUHI2WlpZcXBBanZ4cFZCcWFTcnJN?=
 =?utf-8?B?SkQzeDhHUitIOUZjcHFYM2ozditoZmdLNHFGZGhyazRwYmk2cVE1a2k5OGJs?=
 =?utf-8?B?c2lmaWtXdnB6ZVJkU0dwZ0pxckwreVdiSjgvdkV1dUVySlc4dz09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc68af04-4af9-4031-76de-08dbce270359
X-MS-Exchange-CrossTenant-AuthSource: MW4PR03MB6428.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 09:05:16.1008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWWB9j0JJ8qzKjrRnBCwBdhhKvSjBrJPK0sdYgdb15lhbFAoXsU5DMpeoISOYyzIT+b3VzM3men2u3Mb2fAUxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 04:49:23PM +0100, Marek Marczykowski-Górecki wrote:
> Linux enables MSI-X before disabling INTx, but keeps MSI-X masked until
> the table is filled. Then it disables INTx just before clearing MASKALL
> bit. Currently this approach is rejected by xen-pciback.
> According to the PCIe spec, device cannot use INTx when MSI/MSI-X is
> enabled (in other words: enabling MSI/MSI-X implicitly disables INTx).
> 
> Change the logic to consider INTx disabled if MSI/MSI-X is enabled. This
> applies to three places:
>  - checking currently enabled interrupts type,
>  - transition to MSI/MSI-X - where INTx would be implicitly disabled,
>  - clearing INTx disable bit - which can be allowed even if MSI/MSI-X is
>    enabled, as device should consider INTx disabled anyway in that case

Is this last point strictly needed?  From the description above it
seems Linux only cares about enabling MSI(-X) without the disable INTx
bit set.

> 
> Fixes: 5e29500eba2a ("xen-pciback: Allow setting PCI_MSIX_FLAGS_MASKALL too")
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> ---
> Changes in v3:
>  - allow clearing INTx regardless of MSI/MSI-X state, to be consistent
>    with enabling MSI/MSI-X
> Changes in v2:
>  - restructure the patch to consider not only MASKALL bit, but enabling
>    MSI/MSI-X generally, without explicitly disabling INTx first
> ---
>  drivers/xen/xen-pciback/conf_space.c          | 19 +++++++++++------
>  .../xen/xen-pciback/conf_space_capability.c   |  3 ++-
>  drivers/xen/xen-pciback/conf_space_header.c   | 21 +++----------------
>  3 files changed, 18 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/xen/xen-pciback/conf_space.c b/drivers/xen/xen-pciback/conf_space.c
> index 059de92aea7d..d47eee6c5143 100644
> --- a/drivers/xen/xen-pciback/conf_space.c
> +++ b/drivers/xen/xen-pciback/conf_space.c
> @@ -288,12 +288,6 @@ int xen_pcibk_get_interrupt_type(struct pci_dev *dev)
>  	u16 val;
>  	int ret = 0;
>  
> -	err = pci_read_config_word(dev, PCI_COMMAND, &val);
> -	if (err)
> -		return err;
> -	if (!(val & PCI_COMMAND_INTX_DISABLE))
> -		ret |= INTERRUPT_TYPE_INTX;
> -
>  	/*
>  	 * Do not trust dev->msi(x)_enabled here, as enabling could be done
>  	 * bypassing the pci_*msi* functions, by the qemu.
> @@ -316,6 +310,19 @@ int xen_pcibk_get_interrupt_type(struct pci_dev *dev)
>  		if (val & PCI_MSIX_FLAGS_ENABLE)
>  			ret |= INTERRUPT_TYPE_MSIX;
>  	}

Since we are explicitly hiding INTx now, should we also do something
about MSI(X) being both enabled at the same time?  The spec states:

"System configuration software sets one of these bits to enable either
MSI or MSI-X, but never both simultaneously. Behavior is undefined if
both MSI and MSI-X are enabled simultaneously."

So finding both MSI and MSI-X enabled likely means something has gone
very wrong?  Likely to be done in a separate change, just realized
while looking at the patch context.

> +
> +	/*
> +	 * PCIe spec says device cannot use INTx if MSI/MSI-X is enabled,
> +	 * so check for INTx only when both are disabled.
> +	 */
> +	if (!ret) {
> +		err = pci_read_config_word(dev, PCI_COMMAND, &val);
> +		if (err)
> +			return err;
> +		if (!(val & PCI_COMMAND_INTX_DISABLE))
> +			ret |= INTERRUPT_TYPE_INTX;
> +	}
> +
>  	return ret ?: INTERRUPT_TYPE_NONE;
>  }
>  
> diff --git a/drivers/xen/xen-pciback/conf_space_capability.c b/drivers/xen/xen-pciback/conf_space_capability.c
> index 097316a74126..eb4c1af44f5c 100644
> --- a/drivers/xen/xen-pciback/conf_space_capability.c
> +++ b/drivers/xen/xen-pciback/conf_space_capability.c
> @@ -236,10 +236,11 @@ static int msi_msix_flags_write(struct pci_dev *dev, int offset, u16 new_value,
>  		return PCIBIOS_SET_FAILED;
>  
>  	if (new_value & field_config->enable_bit) {
> -		/* don't allow enabling together with other interrupt types */
> +		/* don't allow enabling together with other interrupt type */

This comment needs to be adjusted to note that we allow enabling while
INTx is not disabled in the command register, in order to please
Linuxes MSI(-X) startup sequence.

FWIW, another option would be to simply disable INTX here once MSI(-X)
is attempted to be enabled, won't that avoid having to modify
xen_pcibk_get_interrupt_type()?

Thanks, Roger.
