Return-Path: <linux-kernel+bounces-17430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 304AD824D1E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90274B2290F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478C3210F;
	Fri,  5 Jan 2024 02:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h9177BrR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="C0FWJbWi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E620E6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 02:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704422653; x=1735958653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XSAJeju+jNAzNCNUFJDpFr77LGfA7vjP5+w9V6ouZ4I=;
  b=h9177BrRB0czhTFPuIGJH3je9ePAF6eI2s7UInr2eqYocLh6lLn0fS37
   YDkW+tG26GuibM5iKQ7fa4HsjYTfaGLaOOKUnUYsfc/enxcHHoJ9GtBs/
   Epm4PqCKmOmPhJ7DU7CCZ/sAjKeBkPqSarsL+dJcD/b/rYrH3hJh4clGK
   1CNuL32DSsCF0IQYJiwcjHWufUhA32f4bu9dgqx/vMbhH/Iw7nr5ywHsp
   ETedTxvblYeQY1XdN1DJRvrlJ0OJ0iwy103nxJFv2X6Q1mSqkH3alIere
   Atcmj9PxYmkmxI5UY1RHEkv5cXhEIlJl7f3vRnl118XnlN4jmtDn/UaSc
   Q==;
X-CSE-ConnectionGUID: sHLw2r6VRu2dW206RYRIrQ==
X-CSE-MsgGUID: 0QC2Zvl6Tc+ipiApZ5jL5w==
X-IronPort-AV: E=Sophos;i="6.04,332,1695657600"; 
   d="scan'208";a="6305360"
Received: from mail-mw2nam04lp2169.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.169])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jan 2024 10:44:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjpCphYydImLoO2I1+sAj3qhx9/Ie1napqZIx+crbbpMTQbzBtJThBe1EOu6Kc83Zflb19j7fLnCZ9EpBicu2HPinTNhXwMXr1Ur7RL5u9ivwxRBZEj7ecW545jFRrAguNJBUDexKkPPvWEE6iGoviVap3VZdBkeI7bR08zetKiMzqoP/nrgJewyALvODITFKg1VHyGU+U2DhUIbc6Jzl51+g134kMH3+RZspjNfq2ibRKFf/BdzjC04MhH5lyXupBLOTlDvCsTJ5SCS6twcuOY7wFKaMioRMDvaZJOKHKfw66Q20UlVilNUJE06+ATay+Cnh7JSxyFp2JdLvkodpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NW9ey4EhJojpfDBX846kOe0SIFfrcVJbhxx6BXMSAU=;
 b=g3hk346YJY3aeAxD5hK6545znB/38VoZgWUIxYbAl6ZBpxilZbZKaqJIilZQtBr2XvtQdmNesPpPiSbCJ1lq3C8nTZuwgNMFFIcS5i0tCr27kEkkvskzA/mkN3AQbhWnebVtCVNmsOG6Ytvu4+4IoPcT81Lz8/CDJU8jAWum/wE9UCtO8ODdzX4xJy8YvRnHlVkDMSC7VjEfQByVzBP09H+7t30val5j3VLNFl1bHynvvj98WuUlDHC46BRj69KjN9JczJXu4shUyzKaXpzLRxBh3DKxwznHrnlkdB8+gtM6bXSEvc0UaO3uDB8uD/swHdiSKAYGHxb7rGPzJxMuGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NW9ey4EhJojpfDBX846kOe0SIFfrcVJbhxx6BXMSAU=;
 b=C0FWJbWiXlfQoIgJ5BQ0p5S5YIrMYm5uTiLUIqygApjcpfHJOdEa38Ke68N9G8qPqMVOCHGBN+Hn3ciqa5fnqIRdl1MogOv3OHFeLZmn6Y/0c0D0f7+uiJ9gX/NSDetxbNqMgbLmtHS2xn1xkAWsE7GkrBthvUHI1NaJn0FasB8=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7376.namprd04.prod.outlook.com (2603:10b6:a03:295::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 02:44:08 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::40c3:517e:80e1:e84e]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::40c3:517e:80e1:e84e%5]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 02:44:08 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Tejun Heo <tj@kernel.org>
CC: "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCHSET wq/for-6.8] workqueue: Implement system-wide max_active
 for unbound workqueues
Thread-Topic: [PATCHSET wq/for-6.8] workqueue: Implement system-wide
 max_active for unbound workqueues
Thread-Index: AQHaMxW+fup8mSSkJ02yqXaFIZNHL7DKm++A
Date: Fri, 5 Jan 2024 02:44:08 +0000
Message-ID: <e3r47rru6go5fqxl5issvduzzmsxrtkefigrkfcnqiuouxm467@72hfzpblzr36>
References: <20231220072529.1036099-1-tj@kernel.org>
In-Reply-To: <20231220072529.1036099-1-tj@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ0PR04MB7376:EE_
x-ms-office365-filtering-correlation-id: d9f88d4a-ccd0-493e-fa31-08dc0d9830c6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UDL2ykrJU0pw/IzW6t4OZ6k4oT8pARqn3gxwJcbkS6Mh+mu4D9xtN6l0n7qWWFvOcFVc+kyr5bQBzf/StqoeQu8mi5US7I22EVwBma0R+0iDJLJGP8hKTZQs2YLfX0a/gsSjgrdPziigBQBcQsfo/IFm2Z1rZNSysYst37/6NsOJYFFzAivZrjNJO8BGRi0SrWCicPaUtq0v2RItNcPu5t12acQuQnWN4Q/765aUgRIfJEDB8xqochE2KaFZB2Px9TXa1S1Ht2NDZ0cr16aqgLH4gjd5t9QVgKYxlzKQF7opSPVUJ/yVTfTN/mrLD+weXXsuLpq0kD4y4BbsERqZ1M6tfyHM6z6y6vD/eh2MaMpzIRaa9SUMtiV0qk2KwBef4HmGynTnuaP+4ysoWsHspn1dYj32T1O/6lbAOd4xQUkFcV8RaJYjS3r168FDYYzWVkhoKyjoPp3BiB9Hv448YJlSHuACsoZIiLJFX1vxDGd3o2ZLBwiaQAgf+beU7jghgKIERmUQwU+pGNTlD8DRG0XtWGacGYdfjlRh4z6iJvdljB5ksvwja70mPB/sd4ptcew4g7Jco21TPxA1m2DxVpK77OrodzokrZ5ta9/BDJM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66899024)(26005)(71200400001)(9686003)(6512007)(6506007)(19627235002)(478600001)(6486002)(966005)(38100700002)(122000001)(86362001)(82960400001)(2906002)(5660300002)(33716001)(41300700001)(83380400001)(66946007)(38070700009)(76116006)(91956017)(6916009)(64756008)(66556008)(54906003)(316002)(66446008)(66476007)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JYpdTsk53QzTHfPqQ+L5cOuPuFZBXhzFDqHjbGAkql3Twy+lENqbe326Vh2+?=
 =?us-ascii?Q?MeNtP/5BWQsrNdXqdl2khLArQwFv5AH9DakD6rnFvjD3YJqgRuWTnARVcxoy?=
 =?us-ascii?Q?tKb+JpQ4OCZMUGvkyjYadj2PXtYGxLQMnTddqr1txjIjhFU/N25CMrInNm67?=
 =?us-ascii?Q?daClZLIG6A/HUafiDbXdURV6vULNRvzpPvJ2TY66Y0J69c2fi43w9Qn5GEXl?=
 =?us-ascii?Q?e7y2Ec34IuLgCQH7GA1Xs5FXK3GGBbcK4/brv5/67YRffntiac0Q7NSU7FZ6?=
 =?us-ascii?Q?v4GcvTK35kWM3V0anCMIIm2lwocVXAcVJdwE6XjMaTNMZ6BpontWkFUCZc6y?=
 =?us-ascii?Q?7+zNI5yov7Cuk1JRRsw8T/pHZjkGmj+hrww52mkZZIbsCF3YL4EVgkBFFgtV?=
 =?us-ascii?Q?FtXbg7mLJ6pqlOiSNCbCjTyrYPnBjw3m8uWBSTCyehrWuSs1uxbAF67pzzzW?=
 =?us-ascii?Q?O2Pg/B/g33w1LlyV12zKAWBevj3fNn69daQlVrRVJbU4XuT4lgP7NHAv5jao?=
 =?us-ascii?Q?YEvEcg1E2RX0+4Qqz4fbIQxa1psBpgaj/Xx2tz76py76z3JVkhLa3ioWqTfB?=
 =?us-ascii?Q?+OUhN7kX3XHvWlNKy60C1Kg4y60oQ0SK+vl5lMIFqYVVjZTVOAoukvQH1VX1?=
 =?us-ascii?Q?eYMESd+LpObAH96SisI8auYTxjBXwnkeoFO0fbZx/i/NTyG6wPBlNMT0MG74?=
 =?us-ascii?Q?IG9PzTSnH5XVQUErx8hsHxMVyuYS7hAaR66OntKCcAf67rqnaLdDA5vVOHYJ?=
 =?us-ascii?Q?d86OSPWaeqzpJIy0MWpB5KjDRcdRplHZ5No/bwd3xYa/TgyG95+M5LmDptH2?=
 =?us-ascii?Q?6/0Psb0saLCTk/o1YZn5JdRmcInM3OMIUPbIWIc+NL2u9pYrGoSQGw7IoBx6?=
 =?us-ascii?Q?tEQsPrwv90h2YtnyYI0iMR8pHuuGDOs8oJ2oOWhOZFCk8Md72chpm44Kicc2?=
 =?us-ascii?Q?Lw6bAR/DjmMcinDWoHPwUMk8xayvTIQBF5c/yOthRqWzTpYl5gfnrW0C2VVb?=
 =?us-ascii?Q?MQ5pxaUE4Kh7cWm7NKsAlo+6x+Ws9014LQgMy/KxcBEOtTyEeUiA7uyUZtHd?=
 =?us-ascii?Q?BRGsDPO85zPhuCC4la3Ey6hVdyoBKp0Lbcqcjz6ethQGRrmJdSvqFrlrDySB?=
 =?us-ascii?Q?prFqTBDE3EPIxUppSTcwYvlnJmVVFIej+1Srrf9sAOJf70AENXdr83uCkibl?=
 =?us-ascii?Q?ZF3NeLm4JYFiP4qy2VkiXSoRsdvLTAnREzdO0CShNaAYgvpdRXGpOzpRmhfV?=
 =?us-ascii?Q?EOI7uXL/VtKx+3SaljrIwM8B5ZbvUf/limNF5PzPPdLFBV353A2kzlRZWu6E?=
 =?us-ascii?Q?RHWUVU6F9fPm9gqIGUwyp968VyK08RdUV7Bq2bFMzPKLujG3o9fJaoaYS9C9?=
 =?us-ascii?Q?47tmC1zcxCUf8C4luHGCMks/g+YCw//C9bx8OEkvT/PWvdbKoTFQooZK1O5b?=
 =?us-ascii?Q?aODESeiOnyK1WTkOilnDhOVmOwZh4KeomipFxkrUWC6Oc978L1izY19IgHIy?=
 =?us-ascii?Q?m/uoXZF1pSDk69l0pnD+jABbOaTdW1AWVY2rVdITkn8fviCZxa6oyoHuzRZ3?=
 =?us-ascii?Q?P52qOXY3wsIsJ3ofZ9AjjnZC6BsEcryRumgotnyLFO9bWLelel1OVxiICWhX?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3FA9CA9953300146A6396AB1EB638089@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j+kD0tduZP4HgPr1By214NlcFmCppL16RR6GgvLAcbeia/XrIWpjTIwB6JkNVEJ53Ugb3XH2pNM+1MYm4TYgSgByU+AUSAZRTYR3AL0PxdYyCv0CZnPrL/VzyhdTnAUWecOH7wq4ZICgJFMzgj+a33c/LJ5zJUsGsSWrL9EeSuYdczUwyyVrfFqAeaK8P+MoYPdIfQsTz+3Db6jY8Nus4u4OEz9MxRTnrkYQ+P/vBlqCskDVduLnNF/5YrXYHXJdTgnwKiUflOf00/SwINFPGyLXAdxRcSp48cqvzbc5Ed5ut/J0vu6sl1TM0sZ+WJqvRFEL1Dd41Kk9ZXaOyNXGZ3OtfSANXLqr8iMJMSAVkxEv/aAhIE8YHijkrklUIr8i4KMBoqru7ARnp1dLWxWIctgdgnrCvGW8Zt9LJNvZPlc6K/EIoziTVE0mWiwEm1gtJwCqrnz5sSoSL8pm0fndrfcCtn9D8AnYTy+SKKVNPuhFFYC6b7krsDdYahWwLEgjPUhRV5uf3KjiJ+uGwjI56qxUCs05z3PkTEO8JEbAYgAJh22zq56zSRey2I+rR0zh3Vuqp3wB/zHM3xbTav3ygXb9te2KD8ftv1owIEX0B+cT9dh1f73uP/qXnz/N+Vi2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f88d4a-ccd0-493e-fa31-08dc0d9830c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 02:44:08.3907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j+9D35hQlyISz0geFJmdeAuf6PGoOZVw5uoyVj6PulQeu/kUdBV8cXeOruwimqljBVVBEwIlGbL+gVbgeQP29Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7376

On Wed, Dec 20, 2023 at 04:24:31PM +0900, Tejun Heo wrote:
> Hello,
>=20
> A pool_workqueue (pwq) represents the connection between a workqueue and =
a
> worker_pool. One of the roles that a pwq plays is enforcement of the
> max_active concurrency limit. Before 636b927eba5b ("workqueue: Make unbou=
nd
> workqueues to use per-cpu pool_workqueues"), there was one pwq per each C=
PU
> for per-cpu workqueues and per each NUMA node for unbound workqueues, whi=
ch
> was a natural result of per-cpu workqueues being served by per-cpu pools =
and
> unbound by per-NUMA pools.
>=20
> In terms of max_active enforcement, this was, while not perfect, workable=
.
> For per-cpu workqueues, it was fine. For unbound, it wasn't great in that
> NUMA machines would get max_active that's multiplied by the number of nod=
es
> but didn't cause huge problems because NUMA machines are relatively rare =
and
> the node count is usually pretty low.
>=20
> However, cache layouts are more complex now and sharing a worker pool acr=
oss
> a whole node didn't really work well for unbound workqueues. Thus, a seri=
es
> of commits culminating on 8639ecebc9b1 ("workqueue: Make unbound workqueu=
es
> to use per-cpu pool_workqueues") implemented more flexible affinity
> mechanism for unbound workqueues which enables using e.g. last-level-cach=
e
> aligned pools. In the process, 636b927eba5b ("workqueue: Make unbound
> workqueues to use per-cpu pool_workqueues") made unbound workqueues use
> per-cpu pwqs like per-cpu workqueues.
>=20
> While the change was necessary to enable more flexible affinity scopes, t=
his
> came with the side effect of blowing up the effective max_active for unbo=
und
> workqueues. Before, the effective max_active for unbound workqueues was
> multiplied by the number of nodes. After, by the number of CPUs.
>=20
> 636b927eba5b ("workqueue: Make unbound workqueues to use per-cpu
> pool_workqueues") claims that this should generally be okay. It is okay f=
or
> users which self-regulates concurrency level which are the vast majority;
> however, there are enough use cases which actually depend on max_active t=
o
> prevent the level of concurrency from going bonkers including several IO
> handling workqueues that can issue a work item for each in-flight IO. Wit=
h
> targeted benchmarks, the misbehavior can easily be exposed as reported in
> http://lkml.kernel.org/r/dbu6wiwu3sdhmhikb2w6lns7b27gbobfavhjj57kwi2quafg=
wl@htjcc5oikcr3.
>=20
> Unfortunately, there is no way to express what these use cases need using
> per-cpu max_active. A CPU may issue most of in-flight IOs, so we don't wa=
nt
> to set max_active too low but as soon as we increase max_active a bit, we
> can end up with unreasonable number of in-flight work items when many CPU=
s
> issue IOs at the same time. ie. The acceptable lowest max_active is highe=
r
> than the acceptable highest max_active.
>=20
> Ideally, max_active for an unbound workqueue should be system-wide so tha=
t
> the users can regulate the total level of concurrency regardless of node =
and
> cache layout. The reasons workqueue hasn't implemented that yet are:
>=20
> - One max_active enforcement decouples from pool boundaires, chaining
>   execution after a work item finishes requires inter-pool operations whi=
ch
>   would require lock dancing, which is nasty.
>=20
> - Sharing a single nr_active count across the whole system can be pretty
>   expensive on NUMA machines.
>=20
> - Per-pwq enforcement had been more or less okay while we were using
>   per-node pools.
>=20
> It looks like we no longer can avoid decoupling max_active enforcement fr=
om
> pool boundaries. This patchset implements system-wide nr_active mechanism
> with the following design characteristics:
>=20
> - To avoid sharing a single counter across multiple nodes, the configured
>   max_active is split across nodes according to the proportion of online
>   CPUs per node. e.g. A node with twice more online CPUs will get twice
>   higher portion of max_active.
>=20
> - Workqueue used to be able to process a chain of interdependent work ite=
ms
>   which is as long as max_active. We can't do this anymore as max_active =
is
>   distributed across the nodes. Instead, a new parameter min_active is
>   introduced which determines the minimum level of concurrency within a n=
ode
>   regardless of how max_active distribution comes out to be.
>=20
>   It is set to the smaller of max_active and WQ_DFL_MIN_ACTIVE which is 8=
.
>   This can lead to higher effective max_weight than configured and also
>   deadlocks if a workqueue was depending on being able to handle chains o=
f
>   interdependent work items that are longer than 8.
>=20
>   I believe these should be fine given that the number of CPUs in each NU=
MA
>   node is usually higher than 8 and work item chain longer than 8 is pret=
ty
>   unlikely. However, if these assumptions turn out to be wrong, we'll nee=
d
>   to add an interface to adjust min_active.
>=20
> - Each unbound wq has an array of struct wq_node_nr_active which tracks
>   per-node nr_active. When its pwq wants to run a work item, it has to
>   obtain the matching node's nr_active. If over the node's max_active, th=
e
>   pwq is queued on wq_node_nr_active->pending_pwqs. As work items finish,
>   the completion path round-robins the pending pwqs activating the first
>   inactive work item of each, which involves some pool lock dancing and
>   kicking other pools. It's not the simplest code but doesn't look too ba=
d.
>=20
> This patchset includes the following patches:
>=20
>  0001-workqueue-Move-pwq-max_active-to-wq-max_active.patch
>  0002-workqueue-Factor-out-pwq_is_empty.patch
>  0003-workqueue-Replace-pwq_activate_inactive_work-with-__.patch
>  0004-workqueue-Move-nr_active-handling-into-helpers.patch
>  0005-workqueue-Make-wq_adjust_max_active-round-robin-pwqs.patch
>  0006-workqueue-Add-first_possible_node-and-node_nr_cpus.patch
>  0007-workqueue-Move-pwq_dec_nr_in_flight-to-the-end-of-wo.patch
>  0008-workqueue-Introduce-struct-wq_node_nr_active.patch
>  0009-workqueue-Implement-system-wide-nr_active-enforcemen.patch
>  0010-workqueue-Reimplement-ordered-workqueue-using-shared.patch
>=20
> This pachset is also available in the following git branch.
>=20
>  https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git unbound-system=
-wide-max_active

Thank you for the series. I applied the patches on btrfs's development tree
below, and ran the benchmark.

https://gitlab.com/kdave/btrfs-devel.git misc-next

- misc-next, numa=3Doff (baseline)
  WRITE: bw=3D1117MiB/s (1171MB/s), 1117MiB/s-1117MiB/s (1171MB/s-1171MB/s)=
, io=3D332GiB (356GB), run=3D304322-304322msec
- misc-next + wq patches, numa=3Doff
  WRITE: bw=3D1866MiB/s (1957MB/s), 1866MiB/s-1866MiB/s (1957MB/s-1957MB/s)=
, io=3D684GiB (735GB), run=3D375472-375472msec

So, the patches surely improved the performance. However, as show below, it
is still lower than reverting previous workqueue patches. The reverting is
done by reverse applying output of "git diff 4cbfd3de737b
kernel/workqueue.c kernel/workqueue_internal.h include/linux/workqueue*
init/main.c"

- misc-next + wq reverted, numa=3Doff
  WRITE: bw=3D2472MiB/s (2592MB/s), 2472MiB/s-2472MiB/s (2592MB/s-2592MB/s)=
, io=3D732GiB (786GB), run=3D303257-303257msec

I also tested Lai Jiangshan's patches as below.

https://lore.kernel.org/all/20231227145143.2399-1-jiangshanlai@gmail.com/

- misc-next+wq another approach, numa=3Doff
  WRITE: bw=3D1697MiB/s (1780MB/s), 1697MiB/s-1697MiB/s (1780MB/s-1780MB/s)=
, io=3D678GiB (728GB), run=3D409213-409213msec

>=20
> diffstat follows.
>=20
>  include/linux/workqueue.h |   35 ++-
>  kernel/workqueue.c        |  669 +++++++++++++++++++++++++++++++++++++++=
+++++++++-------------
>  2 files changed, 565 insertions(+), 139 deletions(-)
>=20
> --
> tejun=

